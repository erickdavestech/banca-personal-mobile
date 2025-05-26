import 'dart:core';
import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core_finish_status.dart';
//import 'package:fphi_sdkmobile_core/fphi_sdkmobile_core_error_type.dart';

class SelphIDResult {
  final SdkFinishStatus finishStatus;
  final String finishStatusDescription;
  final String errorDiagnostic;
  final String? errorMessage;
  final String frontDocumentImage;
  final String backDocumentImage;
  final String rawBackDocument;
  final String rawFrontDocument;
  final String fingerprintImage;
  final String faceImage;
  final String signatureImage;
  final String tokenRawBackDocument;
  final String tokenRawFrontDocument;
  final String tokenFrontDocument;
  final String tokenBackDocument;
  final String tokenFaceImage;
  final String documentData;
  final String tokenOCR;
  final String documentCaptured;
  final double matchingSidesScore;

  const SelphIDResult({
    required this.finishStatus,
    required this.finishStatusDescription,
    required this.errorDiagnostic,
    required this.errorMessage,
    required this.frontDocumentImage,
    required this.backDocumentImage,
    required this.rawBackDocument,
    required this.rawFrontDocument,
    required this.fingerprintImage,
    required this.faceImage,
    required this.signatureImage,
    required this.tokenRawBackDocument,
    required this.tokenRawFrontDocument,
    required this.tokenFrontDocument,
    required this.tokenBackDocument,
    required this.tokenFaceImage,
    required this.documentData,
    required this.tokenOCR,
    required this.documentCaptured,
    required this.matchingSidesScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'finishStatus': finishStatus.toInt(),
      'finishStatusDescription': finishStatusDescription,
      'errorDiagnostic': errorDiagnostic,
      'errorMessage': errorMessage,
      'frontDocumentImage': frontDocumentImage,
      'backDocumentImage': backDocumentImage,
      'rawFrontDocument': rawFrontDocument,
      'rawBackDocument': rawBackDocument,
      'fingerprintImage': fingerprintImage,
      'faceImage': faceImage,
      'signatureImage': signatureImage,
      'tokenFrontDocument': tokenFrontDocument,
      'tokenBackDocument': tokenBackDocument,
      'tokenRawFrontDocument': tokenRawFrontDocument,
      'tokenRawBackDocument': tokenRawBackDocument,
      'tokenFaceImage': tokenFaceImage,
      'documentData': documentData,
      'tokenOCR': tokenOCR,
      'documentCaptured': documentCaptured,
      'matchingSidesScore': matchingSidesScore,
    };
  }

  static SelphIDResult fromMap(Map<dynamic, dynamic> map) {
    return SelphIDResult(
      finishStatus: SdkFinishStatus.getEnum(map['finishStatus']),
      finishStatusDescription: map['finishStatusDescription'],
      errorDiagnostic: map['errorDiagnostic'] ?? "",
      errorMessage: map['errorMessage'] ?? "",
      frontDocumentImage: map['frontDocumentImage'] ?? "",
      backDocumentImage: map['backDocumentImage'] ?? "",
      rawFrontDocument: map['rawFrontDocument'] ?? "",
      rawBackDocument: map['rawBackDocument'] ?? "",
      fingerprintImage: map['fingerprintImage'] ?? "",
      faceImage: map['faceImage'] ?? "",
      signatureImage: map['signatureImage'] ?? "",
      tokenFrontDocument: map['tokenFrontDocument'] ?? "",
      tokenBackDocument: map['tokenBackDocument'] ?? "",
      tokenRawBackDocument: map["tokenRawBackDocument"] ?? "",
      tokenRawFrontDocument: map["tokenRawFrontDocument"] ?? "",
      tokenFaceImage: map['tokenFaceImage'] ?? "",
      documentData: map['documentData'] ?? "",
      tokenOCR: map['tokenOCR'] ?? "",
      documentCaptured: map['documentCaptured'] ?? "",
      matchingSidesScore: map['matchingSidesScore'] ?? 0.00,
    );
  }

  @override
  String toString() {
    return 'SelphIDResult(finishStatus: $finishStatus, errorDiagnostic: $errorDiagnostic, errorMessage: $errorMessage, finishStatusDescription: $finishStatusDescription, frontDocumentImage: $frontDocumentImage,  backDocumentImage: $backDocumentImage, faceImage: $faceImage, tokenFrontDocument: $tokenFrontDocument, tokenBackDocument: $tokenBackDocument, tokenFaceImage: $tokenFaceImage, documentData: $documentData, tokenOCR: $tokenOCR, documentCaptured: $documentCaptured, matchingSidesScore: $matchingSidesScore)';
  }
}
