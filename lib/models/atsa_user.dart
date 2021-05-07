import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AtsaUser {
  AtsaUser({
    this.name,
    this.surname,
    @required this.email,
    @required this.dni,
    @required this.status,
    @required this.createdAt,
    this.docId,
    this.formRef,
  });

  AtsaUser.fromJson(Map<String, Object> json)
      : name = json['name'] as String,
        surname = json['surname'] as String,
        email = json['email'] as String,
        dni = json['dni'] as String,
        status = json['status'] as String,
        createdAt = json['createdAt'] as Timestamp,
        docId = json['docId'] as String,
        formRef = json['formRef'] as DocumentReference;

  final String name;
  final String surname;
  final String email;
  final String dni;
  final String status;
  final Timestamp createdAt;
  final String docId;
  final DocumentReference formRef;

  AtsaUser copyWith({
    String name,
    String surname,
    String email,
    String dni,
    String status,
    Timestamp createdAt,
    String docId,
    DocumentReference formRef,
  }) =>
      AtsaUser(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        dni: dni ?? this.dni,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        docId: docId ?? this.docId,
        formRef: formRef ?? this.formRef,
      );

  Map<String, Object> toJson() => <String, Object>{
        'name': name,
        'surname': surname,
        'email': email,
        'dni': dni,
        'status': status,
        'createdAt': createdAt,
        'docId': docId,
        'formRef': formRef,
      };
}
