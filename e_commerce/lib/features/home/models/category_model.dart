import 'dart:convert';

import 'package:e_commerce/core/network/remote/endpoints.dart';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  int id;
  String name;
  String avatar;

  CategoryModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"].replaceAll("http://localhost:8801/", Endpoint.baseUrl),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}