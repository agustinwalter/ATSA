import 'package:atsa/models/atsa_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FormProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _userUid = FirebaseAuth.instance.currentUser.uid;

  AtsaForm form = AtsaForm();
  int formStep = 0;

  void setPersonalData({
    @required String email,
    @required int personalPhone,
    @required String personalAddress,
    @required String personalCity,
    @required String dateOfBirth,
    @required String civilStatus,
  }) {
    form.email = email;
    form.personalPhone = personalPhone;
    form.personalAddress = personalAddress;
    form.personalCity = personalCity;
    form.dateOfBirth = dateOfBirth;
    form.civilStatus = civilStatus;
    formStep = 1;
    notifyListeners();
  }

  Future<void> sendForm({
    @required String work,
    @required String profession,
    @required String file,
    @required int workPhone,
    @required String workAddress,
    @required String workCity,
    @required String month,
  }) async {
    form.work = work;
    form.profession = profession;
    form.file = file;
    form.workPhone = workPhone;
    form.workAddress = workAddress;
    form.workCity = workCity;
    form.month = month;
    await _db.collection('forms').doc(_userUid).set(form.toJson());
  }

  void prevStep() {
    formStep = 0;
    notifyListeners();
  }
}
