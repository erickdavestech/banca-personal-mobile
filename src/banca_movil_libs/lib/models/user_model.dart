import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? token;
  bool? isSessionActive;
  User? user;
  DateTime? expiration;
  String? refreshToken;

  UserModel({
    this.token,
    this.isSessionActive,
    this.user,
    this.expiration,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    token: json["token"],
    isSessionActive: json["isSessionActive"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    expiration:
        json["expiration"] == null ? null : DateTime.parse(json["expiration"]),
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "isSessionActive": isSessionActive,
    "user": user?.toJson(),
    "expiration": expiration?.toIso8601String(),
    "refreshToken": refreshToken,
  };
}

class User {
  String? name;
  String? lastname;
  String? username;
  String? email;
  Contact? contact;
  Address? address;
  int? status;
  int? type;
  String? antiPhishingImage;
  int? loginAttempts;
  List<dynamic>? roles;
  String? clientNumber;
  List<dynamic>? companies;
  String? favoriteCompany;
  dynamic selectedLanguage;
  int? authenticationMethod;
  String? trustedImageId;
  bool? hasFavoriteCompanyActivated;
  String? id;
  DateTime? created;
  dynamic updated;

  User({
    this.name,
    this.lastname,
    this.username,
    this.email,
    this.contact,
    this.address,
    this.status,
    this.type,
    this.antiPhishingImage,
    this.loginAttempts,
    this.roles,
    this.clientNumber,
    this.companies,
    this.favoriteCompany,
    this.selectedLanguage,
    this.authenticationMethod,
    this.trustedImageId,
    this.hasFavoriteCompanyActivated,
    this.id,
    this.created,
    this.updated,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    status: json["status"],
    type: json["type"],
    antiPhishingImage: json["antiPhishingImage"],
    loginAttempts: json["loginAttempts"],
    roles:
        json["roles"] == null
            ? []
            : List<dynamic>.from(json["roles"]!.map((x) => x)),
    clientNumber: json["clientNumber"],
    companies:
        json["companies"] == null
            ? []
            : List<dynamic>.from(json["companies"]!.map((x) => x)),
    favoriteCompany: json["favoriteCompany"],
    selectedLanguage: json["selectedLanguage"],
    authenticationMethod: json["authenticationMethod"],
    trustedImageId: json["trustedImageId"],
    hasFavoriteCompanyActivated: json["hasFavoriteCompanyActivated"],
    id: json["id"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lastname": lastname,
    "username": username,
    "email": email,
    "contact": contact?.toJson(),
    "address": address?.toJson(),
    "status": status,
    "type": type,
    "antiPhishingImage": antiPhishingImage,
    "loginAttempts": loginAttempts,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "clientNumber": clientNumber,
    "companies":
        companies == null ? [] : List<dynamic>.from(companies!.map((x) => x)),
    "favoriteCompany": favoriteCompany,
    "selectedLanguage": selectedLanguage,
    "authenticationMethod": authenticationMethod,
    "trustedImageId": trustedImageId,
    "hasFavoriteCompanyActivated": hasFavoriteCompanyActivated,
    "id": id,
    "created": created?.toIso8601String(),
    "updated": updated,
  };
}

class Address {
  dynamic apartmentNo;
  String? country;
  dynamic residential;
  dynamic street;
  String? address;
  String? id;
  DateTime? created;
  dynamic updated;

  Address({
    this.apartmentNo,
    this.country,
    this.residential,
    this.street,
    this.address,
    this.id,
    this.created,
    this.updated,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    apartmentNo: json["apartmentNo"],
    country: json["country"],
    residential: json["residential"],
    street: json["street"],
    address: json["address"],
    id: json["id"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "apartmentNo": apartmentNo,
    "country": country,
    "residential": residential,
    "street": street,
    "address": address,
    "id": id,
    "created": created?.toIso8601String(),
    "updated": updated,
  };
}

class Contact {
  String? cellPhoneNumber;
  dynamic residentialNumber;
  dynamic officeNumber;
  String? additionalPhoneNumber;
  String? identificationNumber;
  int? identificationType;
  String? secondaryEmail;
  String? id;
  DateTime? created;
  dynamic updated;

  Contact({
    this.cellPhoneNumber,
    this.residentialNumber,
    this.officeNumber,
    this.additionalPhoneNumber,
    this.identificationNumber,
    this.identificationType,
    this.secondaryEmail,
    this.id,
    this.created,
    this.updated,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    cellPhoneNumber: json["cellPhoneNumber"],
    residentialNumber: json["residentialNumber"],
    officeNumber: json["officeNumber"],
    additionalPhoneNumber: json["additionalPhoneNumber"],
    identificationNumber: json["identificationNumber"],
    identificationType: json["identificationType"],
    secondaryEmail: json["secondaryEmail"],
    id: json["id"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "cellPhoneNumber": cellPhoneNumber,
    "residentialNumber": residentialNumber,
    "officeNumber": officeNumber,
    "additionalPhoneNumber": additionalPhoneNumber,
    "identificationNumber": identificationNumber,
    "identificationType": identificationType,
    "secondaryEmail": secondaryEmail,
    "id": id,
    "created": created?.toIso8601String(),
    "updated": updated,
  };
}
