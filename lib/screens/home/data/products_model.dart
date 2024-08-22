//
//import 'package:flutter/material.dart';

class ProductsModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  // final bool isFavourite;
  // final bool isCarted;
 ProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    // required this.isFavourite,
    // required this.isCarted
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      // isFavourite: json['isFavourite'],
      // isCarted: json['in_cart'],

    );
  }
}

// class ProductsModel {
//   final int id;
//   final String name;
//   final String image;
//   final double price;
//   bool? isFavourite;

//   ProductsModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     this.isFavourite,
//   });

//   factory ProductsModel.fromJson(Map<String, dynamic> json) {
//     return ProductsModel(
//       id: json['id'],
//       name: json['name'], // Ensure that name is not null
//       image: json['image'] , // Ensure that image is not null
//       price: (json['price'] as num).toDouble(), // Convert price to double
//       isFavourite: json['isFavourite'], // Ensure isFavourite is nullable
//     );
//   }
// }