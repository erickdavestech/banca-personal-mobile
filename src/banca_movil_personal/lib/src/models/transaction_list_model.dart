// // To parse this JSON data, do
// //
// //     final transactionListModel = transactionListModelFromJson(jsonString);

// import 'dart:convert';

// TransactionListModel transactionListModelFromJson(String str) =>
//     TransactionListModel.fromJson(json.decode(str));

// String transactionListModelToJson(TransactionListModel data) =>
//     json.encode(data.toJson());

// class TransactionListModel {
//   List<TransactionDetail>? transactionDetail;
//   int? totalCount;
//   int? page;
//   int? pageSize;

//   TransactionListModel({
//     this.transactionDetail,
//     this.totalCount,
//     this.page,
//     this.pageSize,
//   });

//   factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
//       TransactionListModel(
//         transactionDetail: json["items"] == null
//             ? []
//             : List<TransactionDetail>.from(
//                 json["items"]!.map((x) => TransactionDetail.fromJson(x))),
//         totalCount: json["totalCount"],
//         page: json["page"],
//         pageSize: json["pageSize"],
//       );

//   Map<String, dynamic> toJson() => {
//         "items": transactionDetail == null
//             ? []
//             : List<dynamic>.from(transactionDetail!.map((x) => x.toJson())),
//         "totalCount": totalCount,
//         "page": page,
//         "pageSize": pageSize,
//       };
// }

// class TransactionDetail {
//   double? amount;
//   DateTime? date;
//   DateTime? transactionDate;
//   String? narrative;
//   String? reference;
//   String? transactionCode;
//   String? userName;
//   int? branch;
//   String? bank;
//   IndicatorDc? indicatorDc;

//   TransactionDetail({
//     this.amount,
//     this.date,
//     this.transactionDate,
//     this.narrative,
//     this.reference,
//     this.transactionCode,
//     this.userName,
//     this.branch,
//     this.bank,
//     this.indicatorDc,
//   });

//   factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
//       TransactionDetail(
//         amount: json["amount"]?.toDouble(),
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         transactionDate: json["transactionDate"] == null
//             ? null
//             : DateTime.parse(json["transactionDate"]),
//         narrative: json["narrative"],
//         reference: json["reference"],
//         transactionCode: json["transactionCode"],
//         userName: json["userName"],
//         branch: json["branch"],
//         bank: json["bank"],
//         indicatorDc: indicatorDcValues.map[json["indicatorDc"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "date": date?.toIso8601String(),
//         "transactionDate": transactionDate?.toIso8601String(),
//         "narrative": narrative,
//         "reference": reference,
//         "transactionCode": transactionCode,
//         "userName": userName,
//         "branch": branch,
//         "bank": bank,
//         "indicatorDc": indicatorDcValues.reverse[indicatorDc],
//       };
// }

// enum IndicatorDc { CR, DB }

// final indicatorDcValues =
//     EnumValues({"CR": IndicatorDc.CR, "DB": IndicatorDc.DB});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
