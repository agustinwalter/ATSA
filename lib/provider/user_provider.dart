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
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _listenUserChanges;

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
    await _getUserData(credential.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _listenUserChanges.cancel();
    user = AtsaUser(status: LoginStatus.NOT_LOGGED);
    notifyListeners();
  }

  Future<void> checkEmailVerification() async {
    await _auth.currentUser.reload();
    if (_auth.currentUser.emailVerified) {
      user.emailVerified = true;
      // Try to get user data for verion 1.
      // ignore: always_specify_types
      final query = await _db.collection('users').where('email', isEqualTo: user.email).get();
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
    // ignore: always_specify_types
    final querySnapshot = await _db.collection('business').get();
    business.clear();
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      business.add(Business.fromJson(doc.data()));
    }
  }

  Future<void> resendEmail() async {
    await _auth.currentUser.sendEmailVerification();
  }

  void goToCreateAccount() {
    user.status = LoginStatus.CREATE_ACCOUNT;
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
    final DocumentReference<Map<String, dynamic>> userDoc = _db.doc('users-v2/${user.uid}');
    _listenUserChanges = userDoc.snapshots().listen((DocumentSnapshot<Map<String, dynamic>> doc) {
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
    });
  }

  String _status() => user.status.toString().split('.').last;

  /// After submitting the form, put the user's status as pending affiliation.
  Future<void> updateUserStatus(LoginStatus newStatus) async {
    user.status = newStatus;
    await _db.doc('users-v2/${user.uid}').update(<String, Object>{
      'status': _status(),
    });
    notifyListeners();
  }
}
