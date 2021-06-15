import 'dart:async';
import 'package:atsa/helpers/login_status.dart';
import 'package:atsa/models/atsa_user.dart';
import 'package:atsa/models/business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AtsaUser user = AtsaUser(status: LoginStatus.NOT_LOGGED);
  List<Business> business = <Business>[];
  bool loading = false;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Check if the user already had an open session and if so, get the data of the current user.
  Future<void> initUser() async {
    final User currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _getUserData(currentUser);
    }
  }

  Future<void> signUp({
    @required String email,
    @required String password,
    @required String name,
    @required String surname,
    @required String dni,
  }) async {
    // Create user.
    final UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user.sendEmailVerification();
    // Update local user data.
    user.uid = credential.user.uid;
    user.email = email;
    user.name = name;
    user.surname = surname;
    user.dni = dni;
    user.createdAt = Timestamp.now();
    user.emailVerified = credential.user.emailVerified;
    user.status = LoginStatus.EMAIL_NOT_VERIFIED;
    // Create a user in DB
    await _db.doc('users-v2/${user.uid}').set(<String, dynamic>{
      'name': user.name,
      'surname': user.surname,
      'dni': user.dni,
      'createdAt': user.createdAt,
    });
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // TODO(agustinwalter): Review this method.
    await _getUserData(credential.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = AtsaUser(status: LoginStatus.NOT_LOGGED);
    notifyListeners();
  }

  Future<void> checkEmailVerification() async {
    await _auth.currentUser.reload();
    if (_auth.currentUser.emailVerified) {
      print(_auth.currentUser.emailVerified);
      user.emailVerified = true;
      // Try to get user data for verion 1.
      final QuerySnapshot<Map<String, dynamic>> query =
          await _db.collection('users').where('email', isEqualTo: user.email).get();
      if (query.size == 1) {
        // The user had already used the app, I charge him the revision status that he already had.
        user.createdAt = query.docs[0].get('createdAt') as Timestamp;
        final String statusV1 = query.docs[0].get('status') as String;
        switch (statusV1) {
          case 'Afiliado':
            user.status = LoginStatus.AFFILIATED;
            break;
          case 'Bloqueado':
            user.status = LoginStatus.BLOCKED;
            break;
          case 'No afiliado':
            user.status = LoginStatus.NOT_AFFILIATED;
            break;
          case 'Verificación pendiente':
            user.status = LoginStatus.PENDING_VERIFICATION;
            break;
        }
        await _db.doc('users-v2/${user.uid}').update(<String, dynamic>{
          'createdAt': user.createdAt,
          'status': _status(),
        });
      } else {
        // It is the first time the user uses the app, I put the pending verification status.
        user.status = LoginStatus.PENDING_VERIFICATION;
        await _db.doc('users-v2/${user.uid}').update(<String, dynamic>{
          'status': _status(),
        });
      }
      notifyListeners();
    }
  }

  Future<void> getBusiness() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _db.collection('business').get();
    business.clear();
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      business.add(Business.fromJson(doc.data()));
    }
  }

  Future<void> resendEmail() async {
    await _auth.currentUser.sendEmailVerification();
  }

  // TODO(agustinwalter): Maybe this feature will be removed.
  Future<void> updateInfo(String name, String surname, String dni) async {
    // Get previous verification status, if it had it.
    final QuerySnapshot<Map<String, dynamic>> query =
        await _db.collection('users').where('email', isEqualTo: user.email).get();
    if (query.size == 1) {
      final String prevStatus = query.docs[0].get('status') as String;
      switch (prevStatus) {
        case 'Afiliado':
          user.status = LoginStatus.AFFILIATED;
          break;
        case 'Bloqueado':
          user.status = LoginStatus.BLOCKED;
          break;
        case 'No afiliado':
          user.status = LoginStatus.NOT_AFFILIATED;
          break;
        case 'Verificación pendiente':
          user.status = LoginStatus.PENDING_VERIFICATION;
          break;
      }
    } else {
      user.status = LoginStatus.PENDING_VERIFICATION;
    }
    // Update user info.
    user.name = name;
    user.surname = surname;
    user.dni = dni;
    await _db.doc('users-v2/${user.uid}').update(<String, Object>{
      'name': name,
      'surname': surname,
      'dni': dni,
      'status': _status(),
    });
    notifyListeners();
  }

  void goToCreateAccount() {
    user.status = LoginStatus.CREATE_ACCOUNT;
    notifyListeners();
  }

  void setEmail(String email) => user.email = email;

  Future<void> _getUserData(User firebaseUser) async {
    user.uid = firebaseUser.uid;
    user.emailVerified = firebaseUser.emailVerified;
    if (!user.emailVerified) {
      user.status = LoginStatus.EMAIL_NOT_VERIFIED;
      notifyListeners();
      return;
    }
    final DocumentSnapshot<Map<String, dynamic>> doc = await _db.doc('users-v2/${user.uid}').get();
    if (doc.exists) {
      user = user.updatedFromJson(doc.data());
      switch (doc.get('status') as String) {
        case 'PENDING_VERIFICATION':
          user.status = LoginStatus.PENDING_VERIFICATION;
          break;
        case 'BLOCKED':
          user.status = LoginStatus.BLOCKED;
          break;
        case 'NOT_AFFILIATED':
          user.status = LoginStatus.NOT_AFFILIATED;
          break;
        case 'AFFILIATED':
          user.status = LoginStatus.AFFILIATED;
          break;
        case 'AFFILIATION_FORM_PENDING':
          user.status = LoginStatus.AFFILIATION_FORM_PENDING;
          break;
      }
    }
    notifyListeners();
  }

  String _status() => user.status.toString().split('.').last;

  // TODO(Martin): This should be replaced with server-side logic
  /// Convenience method to manually update the user Status
  Future<void> updateUserStatus(LoginStatus newStatus) async {
    // Update user status.
    user.status = newStatus;

    // Get the String form of the status to update on Firebase
    final String newStr = newStatus.toString();
    String statusStr = newStr.substring(newStr.indexOf('.'), newStr.length);
    print('Status string: $statusStr');

    await _db.doc('users-v2/${user.uid}').update(<String, Object>{
      'status': statusStr,
    });
    notifyListeners();
  }
}
