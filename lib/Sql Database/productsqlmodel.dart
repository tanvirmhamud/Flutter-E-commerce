// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'package:flutter/material.dart';

class ProductModel {
  ProductModel({
    this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.image,
    required this.orderno,
    required this.productno,
  });

  int? id;
  final String name;
  final String details;
  final double price;
  final String image;
  int orderno;
  int productno;

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      details: json["details"],
      price: json["price"],
      image: json["image"],
      orderno: json["orderno"],
      productno: json["productno"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "details": details,
        "price": price,
        "image": image,
        "orderno": orderno,
        "productno": productno,
      };
}
