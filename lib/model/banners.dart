import 'dart:convert';
import 'package:flutter/material.dart';

class BannersObject {
  String image;
  String screen;
  BannersObject({
    @required this.image,
    @required this.screen,
  });

  BannersObject copyWith({
    String image,
    String screen,
  }) {
    return BannersObject(
      image: image ?? this.image,
      screen: screen ?? this.screen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'screen': screen,
    };
  }

  factory BannersObject.fromMap(Map<String, dynamic> map) {
    return BannersObject(
      image: map['image'],
      screen: map['screen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannersObject.fromJson(String source) => BannersObject.fromMap(json.decode(source));

  @override
  String toString() => 'BannersObject(image: $image, screen: $screen)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BannersObject &&
      other.image == image &&
      other.screen == screen;
  }

  @override
  int get hashCode => image.hashCode ^ screen.hashCode;
}
