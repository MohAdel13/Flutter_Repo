import 'dart:convert';

UserAccessModel userAccessModelFromJson(String str) => UserAccessModel.fromJson(json.decode(str));

String userAccessModelToJson(UserAccessModel data) => json.encode(data.toJson());

class UserAccessModel {
  String accessToken;
  String tokenType;
  int expiresIn;

  UserAccessModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory UserAccessModel.fromJson(Map<String, dynamic> json) => UserAccessModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}