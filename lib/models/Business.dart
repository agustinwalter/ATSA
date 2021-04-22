import 'package:flutter/foundation.dart';

class Business {
  final String name;
  final String type;
  final String address;
  final String image;
  final String discount;
  final String details;

  Business({
    @required this.name,
    @required this.type,
    @required this.address,
    @required this.image,
    @required this.discount,
    this.details,
  });

  Business.fromJson(Map<String, Object> json)
      : name = json['name'] as String,
        type = json['type'] as String,
        address = json['address'] as String,
        image = json['image'] as String,
        discount = json['discount'] as String,
        details = json['details'] as String;
}
