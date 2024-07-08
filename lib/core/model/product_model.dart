// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:product_with_bloc/core/model/handling.dart';

class ProductModel extends ResultModel {
  String name;
  String description;
  String image;
  num price;
  String brand;
  ProductModel({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.brand,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    String? image,
    num? price,
    String? brand,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'brand': brand,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
      brand: map['brand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, image: $image, price: $price, brand: $brand)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.price == price &&
      other.brand == brand;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      price.hashCode ^
      brand.hashCode;
  }
}
