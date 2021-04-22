import 'dart:async';
import 'package:atsa/models/AtsaUser.dart';
import 'package:atsa/models/Business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AtsaUser atsaUser;
  List<Business> business = [];
  bool loading = false;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> _listenUser;

  void initUser({@required String dni}) {
    loading = true;
    notifyListeners();
    _listenUser = _db.collection('users').where('dni', isEqualTo: dni).snapshots().listen((snap) {
      if (snap.size == 1) {
        // User exists.
        Map<String, dynamic> userInDB = snap.docs[0].data();
        userInDB = {...userInDB, 'docId': snap.docs[0].id};
        loading = false;
        atsaUser = AtsaUser.fromJson(userInDB);
        notifyListeners();
      } else if (snap.size == 0) {
        // First time.
        AtsaUser newUser = AtsaUser(
          email: '',
          dni: dni,
          status: 'Falta email',
          createdAt: Timestamp.now(),
        );
        Map<String, dynamic> data = newUser.toJson()..remove('docId');
        _db.collection('users').add(data);
      }
    });
  }

  Future<void> addEmail({@required String email}) async {
    await _db.doc('users/${atsaUser.docId}').update({
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
    QuerySnapshot querySnapshot = await _db.collection('business').get();
    business.clear();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      business.add(Business.fromJson(doc.data()));
    }
  }
}
