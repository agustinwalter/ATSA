import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AtsaUser {
  AtsaUser({
    @required this.email,
    @required this.dni,
    @required this.status,
    @required this.createdAt,
    this.docId,
  });

  AtsaUser.fromJson(Map<String, Object> json)
      : email = json['email'] as String,
        dni = json['dni'] as String,
        status = json['status'] as String,
        createdAt = json['createdAt'] as Timestamp,
        docId = json['docId'] as String;

  final String email;
  final String dni;
  final String status;
  final Timestamp createdAt;
  final String docId;

  AtsaUser copyWith({
    String email,
    String dni,
    String status,
    Timestamp createdAt,
    String docId,
  }) =>
      AtsaUser(
        email: email ?? this.email,
        dni: dni ?? this.dni,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        docId: docId ?? this.docId,
      );

  Map<String, Object> toJson() => <String, Object>{
        'email': email,
        'dni': dni,
        'status': status,
        'createdAt': createdAt,
        'docId': docId,
      };
}
