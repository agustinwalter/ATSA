import 'dart:async';
import 'package:atsa/helpers/login_status.dart';
import 'package:atsa/models/atsa_user.dart';
import 'package:atsa/models/business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AtsaUser atsaUser;
  List<Business> business = <Business>[];
  bool loading = false;
  LoginStatus loginStatus = LoginStatus.BLOCKED;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> _listenUser;

  void initUser({@required String dni}) {
    loading = true;
    notifyListeners();
    _listenUser = _db
        .collection('users')
        .where('dni', isEqualTo: dni)
        .snapshots()
        .listen((QuerySnapshot snap) {
      if (snap.size == 1) {
        // User exists.
        Map<String, Object> userInDB = snap.docs[0].data();
        userInDB = <String, Object>{...userInDB, 'docId': snap.docs[0].id};
        loading = false;
        atsaUser = AtsaUser.fromJson(userInDB);
        notifyListeners();
      } else if (snap.size == 0) {
        // First time.
        final AtsaUser newUser = AtsaUser(
          email: '',
          dni: dni,
          status: 'Falta email',
          createdAt: Timestamp.now(),
        );
        final Map<String, Object> data = newUser.toJson()..remove('docId');
        _db.collection('users').add(data);
      }
    });
  }

  Future<void> addEmail({@required String email}) async {
    await _db.doc('users/${atsaUser.docId}').update(<String, Object>{
      'email': email,
      'status': 'Verificación pendiente',
    });
  }

  Future<void> logout() async {
    atsaUser = null;
    _listenUser.cancel();
    notifyListeners();
  }

  Future<void> getBusiness() async {
    final QuerySnapshot querySnapshot = await _db.collection('business').get();
    business.clear();
    for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
      business.add(Business.fromJson(doc.data()));
    }
  }
}
