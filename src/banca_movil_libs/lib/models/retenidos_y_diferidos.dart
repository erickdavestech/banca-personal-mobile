// To parse this JSON data, do
//
//     final retenidosYDiferidos = retenidosYDiferidosFromJson(jsonString);

import 'dart:convert';

RetenidosYDiferidos retenidosYDiferidosFromJson(String str) =>
    RetenidosYDiferidos.fromJson(json.decode(str));

String retenidosYDiferidosToJson(RetenidosYDiferidos data) =>
    json.encode(data.toJson());

class RetenidosYDiferidos {
  String numeroCuenta;
  List<Ido> diferidos;
  List<Ido> retenidos;
  int errorCode;
  String errorDescription;

  RetenidosYDiferidos({
    required this.numeroCuenta,
    required this.diferidos,
    required this.retenidos,
    required this.errorCode,
    required this.errorDescription,
  });

  factory RetenidosYDiferidos.fromJson(
    Map<String, dynamic> json,
  ) => RetenidosYDiferidos(
    numeroCuenta: json["NumeroCuenta"] ?? "",
    diferidos: List<Ido>.from(json["Diferidos"].map((x) => Ido.fromJson(x))),
    retenidos: List<Ido>.from(json["Retenidos"].map((x) => Ido.fromJson(x))),
    errorCode: json["errorCode"],
    errorDescription: json["errorDescription"],
  );

  Map<String, dynamic> toJson() => {
    "NumeroCuenta": numeroCuenta,
    "Diferidos": List<dynamic>.from(diferidos.map((x) => x.toJson())),
    "Retenidos": List<dynamic>.from(retenidos.map((x) => x.toJson())),
    "errorCode": errorCode,
    "errorDescription": errorDescription,
  };
}

class Ido {
  String? referencia;
  String? descripcion;
  String? fechaProceso;
  String? fechaVencimiento;
  String? dias;
  Tipo? tipo;
  SubTipo? subTipo;
  num? monto;

  Ido({
    this.referencia,
    this.descripcion,
    this.fechaProceso,
    this.fechaVencimiento,
    this.dias,
    this.tipo,
    this.subTipo,
    this.monto,
  });

  factory Ido.fromJson(Map<String, dynamic> json) => Ido(
    referencia: json["Referencia"],
    descripcion: json["Descripcion"],
    fechaProceso: json["FechaProceso"],
    fechaVencimiento: json["FechaVencimiento"],
    dias: json["Dias"],
    tipo: tipoValues.map[json["Tipo"]]!,
    subTipo: subTipoValues.map[json["SubTipo"]]!,
    monto:
        json["Monto:"] == null
            ? null
            : num.parse(json["Monto:"].toString().replaceAll(",", "")),
  );

  Map<String, dynamic> toJson() => {
    "Referencia": referencia,
    "Descripcion": descripcion,
    "FechaProceso": fechaProceso,
    "FechaVencimiento": fechaVencimiento,
    "Dias": dias,
    "Tipo": tipoValues.reverse[tipo],
    "SubTipo": subTipoValues.reverse[subTipo],
    "Monto:": monto,
  };
}

enum SubTipo { EMPTY, H }

final subTipoValues = EnumValuesR({"": SubTipo.EMPTY, "H": SubTipo.H});

enum Tipo { DIFERIDO, RETENIDO }

final tipoValues = EnumValuesR({
  "Diferido": Tipo.DIFERIDO,
  "Retenido": Tipo.RETENIDO,
});

class EnumValuesR<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValuesR(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
