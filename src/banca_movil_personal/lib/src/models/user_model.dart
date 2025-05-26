// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   String? userId;
//   String? username;
//   String? id;
//   String? name;
//   String? email;
//   bool? blocked;
//   int? attempts;
//   bool? biometricsVerified;
//   bool? hasFavoriteCompanyActivated;
//   int? clientId;
//   String? identificationType;
//   String? identificationNumber;
//   String? cellPhoneNumber;
//   String? phoneNumber;
//   String? address;
//   String? noHouse;
//   String? street;
//   TrustImage? trustImage;
//   List<Device>? devices;
//   String? favoriteCompany;
//   List<Company>? companies;
//   DateTime? updatedConnection;
//   DateTime? lastConnection;
//   int? iat;
//   int? exp;

//   UserModel({
//     this.userId,
//     this.username,
//     this.id,
//     this.name,
//     this.email,
//     this.blocked,
//     this.attempts,
//     this.biometricsVerified,
//     this.hasFavoriteCompanyActivated,
//     this.clientId,
//     this.identificationType,
//     this.identificationNumber,
//     this.cellPhoneNumber,
//     this.phoneNumber,
//     this.address,
//     this.noHouse,
//     this.street,
//     this.trustImage,
//     this.devices,
//     this.favoriteCompany,
//     this.companies,
//     this.updatedConnection,
//     this.lastConnection,
//     this.iat,
//     this.exp,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         userId: json["userId"],
//         username: json["username"],
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         blocked: json["blocked"],
//         attempts: json["attempts"],
//         biometricsVerified: json["biometricsVerified"],
//         hasFavoriteCompanyActivated: json["hasFavoriteCompanyActivated"],
//         clientId: json["clientId"],
//         identificationType: json["identificationType"],
//         identificationNumber: json["identificationNumber"],
//         cellPhoneNumber: json["cellPhoneNumber"],
//         phoneNumber: json["phoneNumber"],
//         address: json["address"],
//         noHouse: json["noHouse"],
//         street: json["street"],
//         trustImage: json["trustImage"] == null
//             ? null
//             : TrustImage.fromJson(json["trustImage"]),
//         devices: json["devices"] == null
//             ? null
//             : List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
//         favoriteCompany: json["favoriteCompany"],
//         companies: json["companies"] == null
//             ? null
//             : List<Company>.from(
//                 json["companies"].map((x) => Company.fromJson(x))),
//         updatedConnection: json["updatedConnection"] == null
//             ? null
//             : DateTime.parse(json["updatedConnection"]),
//         lastConnection: json["lastConnection"] == null
//             ? null
//             : DateTime.parse(json["lastConnection"]),
//         iat: json["iat"],
//         exp: json["exp"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "username": username,
//         "id": id,
//         "name": name,
//         "email": email,
//         "blocked": blocked,
//         "attempts": attempts,
//         "biometricsVerified": biometricsVerified,
//         "hasFavoriteCompanyActivated": hasFavoriteCompanyActivated,
//         "clientId": clientId,
//         "identificationType": identificationType,
//         "identificationNumber": identificationNumber,
//         "cellPhoneNumber": cellPhoneNumber,
//         "phoneNumber": phoneNumber,
//         "address": address,
//         "noHouse": noHouse,
//         "street": street,
//         "trustImage": trustImage?.toJson(),
//         "devices": List<dynamic>.from(devices!.map((x) => x.toJson())),
//         "favoriteCompany": favoriteCompany,
//         "companies": List<dynamic>.from(companies!.map((x) => x.toJson())),
//         "updatedConnection": updatedConnection?.toIso8601String(),
//         "lastConnection": lastConnection?.toIso8601String(),
//         "iat": iat,
//         "exp": exp,
//       };
// }

// class Company {
//   String id;
//   String name;
//   String ruc;
//   String imageUrl;
//   int clientId;

//   Company({
//     required this.id,
//     required this.name,
//     required this.ruc,
//     required this.imageUrl,
//     required this.clientId,
//   });

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["id"],
//         name: json["name"],
//         ruc: json["ruc"],
//         imageUrl: json["imageUrl"],
//         clientId: json["clientId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "ruc": ruc,
//         "imageUrl": imageUrl,
//         "clientId": clientId,
//       };
// }

// class Device {
//   String ip;
//   String agent;
//   String hostName;
//   String id;

//   Device({
//     required this.ip,
//     required this.agent,
//     required this.hostName,
//     required this.id,
//   });

//   factory Device.fromJson(Map<String, dynamic> json) => Device(
//         ip: json["ip"],
//         agent: json["agent"],
//         hostName: json["hostName"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ip": ip,
//         "agent": agent,
//         "hostName": hostName,
//         "id": id,
//       };
// }

// class TrustImage {
//   int id;
//   String name;

//   TrustImage({
//     required this.id,
//     required this.name,
//   });

//   factory TrustImage.fromJson(Map<String, dynamic> json) => TrustImage(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
