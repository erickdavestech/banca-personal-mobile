import 'dart:core';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core_finish_status.dart';

class SelphiFaceResult {
  final SdkFinishStatus finishStatus;
  final String finishStatusDescription;
  final String errorDiagnostic;
  final String? errorMessage;
  final String? templateRaw;
  final String? qrData;
  final String? bestImage;
  final String? bestImageCropped;
  final String? bestImageTemplateRaw;
  final String? livenessDiagnostic;
  final dynamic images;

  const SelphiFaceResult({
    required this.finishStatus,
    required this.finishStatusDescription,
    required this.errorDiagnostic,
    required this.errorMessage,
    required this.templateRaw,
    required this.qrData,
    required this.bestImage,
    required this.bestImageCropped,
    required this.bestImageTemplateRaw,
    required this.livenessDiagnostic,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'finishStatus': finishStatus.toInt(),
      'finishStatusDescription': finishStatusDescription,
      'errorDiagnostic': errorDiagnostic,
      'errorMessage': errorMessage ?? "",
      'templateRaw': templateRaw,
      'qrData': qrData,
      'bestImage': bestImage,
      'bestImageCropped': bestImageCropped,
      'bestImageTemplateRaw': bestImageTemplateRaw,
      'livenessDiagnostic': livenessDiagnostic ?? "",
      'images': images,
    };
  }

  static SelphiFaceResult fromMap(Map<dynamic, dynamic> map) {
    return SelphiFaceResult(
      finishStatus: SdkFinishStatus.getEnum(map['finishStatus']),
      finishStatusDescription: map['finishStatusDescription'],
      errorDiagnostic: map['errorDiagnostic'] ?? "",
      errorMessage: map['errorMessage'] ?? "",
      templateRaw: map['templateRaw'],
      qrData: map['qrData'],
      bestImage: map['bestImage'],
      bestImageCropped: map['bestImageCropped'],
      bestImageTemplateRaw: map['bestImageTemplateRaw'],
      livenessDiagnostic: map['livenessDiagnostic'] ?? "",
      images: map['images'],
    );
  }

  @override
  String toString() {
    return 'SelphiFaceResult(finishStatus: $finishStatus, errorDiagnostic: $errorDiagnostic, errorMessage: $errorMessage, finishStatusDescription: $finishStatusDescription, templateRaw: $templateRaw, qrData: $qrData, bestImage: $bestImage, bestImageCropped: $bestImageCropped, bestImageTemplateRaw: $bestImageTemplateRaw)';
  }
}
