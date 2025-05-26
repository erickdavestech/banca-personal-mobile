// // To parse this JSON data, do
// //
// //     final tokenModel = tokenModelFromJson(jsonString);

// import 'dart:convert';

// TokenModel tokenModelFromJson(String str) =>
//     TokenModel.fromJson(json.decode(str));

// String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

// class TokenModel {
//   String token;
//   bool isSessionActive;

//   TokenModel({
//     required this.token,
//     required this.isSessionActive,
//   });

//   factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
//         token: json["token"],
//         isSessionActive: json["isSessionActive"],
//       );

//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "isSessionActive": isSessionActive,
//       };
// }
