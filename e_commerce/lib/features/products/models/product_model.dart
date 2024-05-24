import 'dart:convert';

import 'package:e_commerce/core/network/remote/endpoints.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int id;
  String name;
  String avatar;
  String description;
  int initialPrice;
  int discount;
  int price;
  String content;
  int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.initialPrice,
    required this.discount,
    required this.price,
    required this.content,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"].replaceAll('http://localhost:8801/', Endpoint.baseUrl),
    description: json["description"],
    initialPrice: json["initial_price"],
    discount: json["discount"],
    price: json["price"],
    content: json["content"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "description": description,
    "initial_price": initialPrice,
    "discount": discount,
    "price": price,
    "content": content,
    "category_id": categoryId,
  };
}