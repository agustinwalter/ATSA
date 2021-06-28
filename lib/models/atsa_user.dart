import 'package:atsa/helpers/login_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AtsaUser {
  AtsaUser({
    this.uid,
    this.name,
    this.surname,
    this.email,
    this.dni,
    this.emailVerified,
    this.status,
    this.createdAt,
    this.formRef,
  });

  String uid;
  String name;
  String surname;
  String email;
  String dni;
  bool emailVerified;
  LoginStatus status;
  Timestamp createdAt;
  DocumentReference<Object> formRef;

  AtsaUser updatedFromJson(Map<String, Object> json) => AtsaUser(
        uid: json['uid'] as String ?? uid,
        name: json['name'] as String ?? name,
        surname: json['surname'] as String ?? surname,
        email: json['email'] as String ?? email,
        dni: json['dni'] as String ?? dni,
        emailVerified: json['emailVerified'] as bool ?? emailVerified,
        createdAt: json['createdAt'] as Timestamp ?? createdAt,
        formRef: json['formRef'] as DocumentReference<Object> ?? formRef,
      );
}
