import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  String category;
  String description;
  String image;
  int mrp;
  String name;
  String productID;
  String quantity;
  String region;
  String seller;
  bool verify;
  int wholesale;
  int selling;
  Product({
    @required this.category,
    @required this.description,
    @required this.image,
    @required this.mrp,
    @required this.name,
    @required this.productID,
    @required this.quantity,
    @required this.region,
    @required this.seller,
    @required this.verify,
    @required this.wholesale,
    @required this.selling,
  });

  Product copyWith({
    String category,
    String description,
    String image,
    int mrp,
    String name,
    String productID,
    String quantity,
    String region,
    String seller,
    bool verify,
    int wholesale,
    int selling,
  }) {
    return Product(
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      mrp: mrp ?? this.mrp,
      name: name ?? this.name,
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
      region: region ?? this.region,
      seller: seller ?? this.seller,
      verify: verify ?? this.verify,
      wholesale: wholesale ?? this.wholesale,
      selling: selling ?? this.selling,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'image': image,
      'mrp': mrp,
      'name': name,
      'productID': productID,
      'quantity': quantity,
      'region': region,
      'seller': seller,
      'verify': verify,
      'wholesale': wholesale,
      'selling': selling,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      category: map['category'],
      description: map['description'],
      image: map['image'],
      mrp: map['mrp'],
      name: map['name'],
      productID: map['productID'],
      quantity: map['quantity'],
      region: map['region'],
      seller: map['seller'],
      verify: map['verify'],
      wholesale: map['wholesale'],
      selling: map['selling'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(category: $category, description: $description, image: $image, mrp: $mrp, name: $name, productID: $productID, quantity: $quantity, region: $region, seller: $seller, verify: $verify, wholesale: $wholesale, selling: $selling)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.category == category &&
      other.description == description &&
      other.image == image &&
      other.mrp == mrp &&
      other.name == name &&
      other.productID == productID &&
      other.quantity == quantity &&
      other.region == region &&
      other.seller == seller &&
      other.verify == verify &&
      other.wholesale == wholesale &&
      other.selling == selling;
  }

  @override
  int get hashCode {
    return category.hashCode ^
      description.hashCode ^
      image.hashCode ^
      mrp.hashCode ^
      name.hashCode ^
      productID.hashCode ^
      quantity.hashCode ^
      region.hashCode ^
      seller.hashCode ^
      verify.hashCode ^
      wholesale.hashCode ^
      selling.hashCode;
  }
}
