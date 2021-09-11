import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  final String name;
  final String mail;
  final String pincode;
  final String city;
  final String phone;
  User({
    @required this.name,
    @required this.mail,
    @required this.pincode,
    @required this.city,
    @required this.phone,
  });

  User copyWith({
    String name,
    String mail,
    String pincode,
    String city,
  }) {
    return User(
      name: name ?? this.name,
      mail: mail ?? this.mail,
      pincode: pincode ?? this.pincode,
      city: city ?? this.city,
      phone: phone??this.phone
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mail': mail,
      'pincode': pincode,
      'city': city,
      'phone':phone??""
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      mail: map['mail'],
      pincode: map['pincode'],
      city: map['city'],
      phone: map['phone']
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, mail: $mail, pincode: $pincode, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.mail == mail &&
        other.pincode == pincode &&
        other.city == city;
  }

  @override
  int get hashCode {
    return name.hashCode ^ mail.hashCode ^ pincode.hashCode ^ city.hashCode;
  }
}
