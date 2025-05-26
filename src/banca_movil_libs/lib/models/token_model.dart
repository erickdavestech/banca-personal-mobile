import 'dart:convert';

import 'package:banca_movil_libs/models/user_model.dart';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  final String token;
  final bool isSessionActive;
  final String refreshToken;
  final String expiration;
  final UserModel? user;

  TokenModel({
    required this.token,
    required this.isSessionActive,
    required this.refreshToken,
    required this.expiration,
    this.user,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    token: json["token"],
    isSessionActive: json["isSessionActive"],
    refreshToken: json["refreshToken"],
    expiration: json["expiration"],
    user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "isSessionActive": isSessionActive,
    "refreshToken": refreshToken,
    "expiration": expiration,
    "user": user?.toJson(),
  };
}
