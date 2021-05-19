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

  /// Check if there is a user created with this [email].
  Future<void> checkEmail(String email) async {
    final List<String> firebaseUser = await _auth.fetchSignInMethodsForEmail(email);
    if (firebaseUser.isEmpty) {
      user.status = LoginStatus.EMAIL_ENTERED_NOT_USER;
    } else {
      user.status = LoginStatus.EMAIL_ENTERED_YES_USER;
    }
    user.email = email;
    notifyListeners();
  }

  Future<void> signUp(String password) async {
    // Create user.
    final UserCredential credential =
        await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
    // Update local user data.
    user.uid = credential.user.uid;
    user.emailVerified = credential.user.emailVerified;
    user.status = LoginStatus.EMAIL_NOT_VERIFIED;
    // Get version 1 user data.
    final QuerySnapshot<Map<String, dynamic>> query =
        await _db.collection('users').where('email', isEqualTo: user.email).get();
    if (query.size == 1) {
      // Create user doc with version 1 data.
      user.dni = query.docs[0].get('dni') as String;
      user.createdAt = query.docs[0].get('createdAt') as Timestamp;
      await _db.doc('users-v2/${user.uid}').set(<String, dynamic>{
        'dni': user.dni,
        'createdAt': user.createdAt,
      });
    } else {
      // Create user doc without data.
      user.createdAt = Timestamp.now();
      await _db.doc('users-v2/${user.uid}').set(<String, dynamic>{
        'createdAt': user.createdAt,
      });
    }
    await credential.user.sendEmailVerification();
    notifyListeners();
  }

  Future<void> signIn(String password) async {
    final UserCredential credential =
        await _auth.signInWithEmailAndPassword(email: user.email, password: password);
    await _getUserData(credential.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = AtsaUser(status: LoginStatus.NOT_LOGGED);
    notifyListeners();
  }

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
        case 'SEND_USER_DATA':
          user.status = LoginStatus.SEND_USER_DATA;
          break;
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

  Future<void> checkEmailVerification() async {
    await _auth.currentUser.reload();
    if (_auth.currentUser.emailVerified) {
      user.emailVerified = true;
      user.status = LoginStatus.SEND_USER_DATA;
      await _db.doc('users-v2/${user.uid}').update(<String, Object>{
        'status': _status(),
      });
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

  String _status() => user.status.toString().split('.').last;
}
