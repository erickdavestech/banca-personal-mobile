import 'package:banca_movil_comercial/src/bloc/biometria_bloc/biometric_bloc.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/biometric_tips_box.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IDCapturePage extends StatefulWidget {
  const IDCapturePage({super.key});
  static const String routeName = '/IDCapturePage';

  @override
  State<IDCapturePage> createState() => _IDCapturePageState();
}

class _IDCapturePageState extends State<IDCapturePage> {
  bool frontCaptured = false;
  bool backCaptured = false;
  String? errorMessage;
  SelphIDResult? frontResult;
  SelphIDResult? backResult;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiometricBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: color043371),
          title: const Text(
            "ID Capture",
            style: TextStyle(color: color043371, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            width: isTablet ? 400.w(context) : double.infinity,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.h(context)),
          Expanded(child: Image.asset('assets/images/id_instruction.png')),
          SizedBox(height: 16.h(context)),
          Text(
            "Place your ID in a well-lit area. Ensure it’s clearly visible and within the frame.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.w(context), color: color1C274C),
          ),
          SizedBox(height: 24.h(context)),
          const BiometricTipsBox(),
          SizedBox(height: 24.h(context)),

          ElevatedButton(
            onPressed: frontCaptured ? null : () => _captureSide(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: color005199,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50.h(context)),
            ),
            child: Text(
              frontCaptured ? "Front Captured" : "Take Photo (Front)",
            ),
          ),

          SizedBox(height: 16.h(context)),

          ElevatedButton(
            onPressed:
                frontCaptured && !backCaptured
                    ? () => _captureSide(false)
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: color005199,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50.h(context)),
            ),
            child: Text(backCaptured ? "Back Captured" : "Take Photo (Back)"),
          ),

          SizedBox(height: 16.h(context)),

          if (errorMessage != null)
            Text(
              errorMessage!,
              style: TextStyle(color: colorCE1228, fontSize: 13.w(context)),
              textAlign: TextAlign.center,
            ),

          if (frontCaptured && backCaptured)
            Padding(
              padding: EdgeInsets.only(top: 20.h(context)),
              child: ElevatedButton(
                onPressed: () {
                  if (frontResult != null && backResult != null) {
                    final Map<String, dynamic> payload = {
                      "tokenFrontDocument": frontResult!.tokenFrontDocument,
                      "tokenBackDocument": backResult!.tokenBackDocument,
                      "tokenRawFrontDocument":
                          frontResult!.tokenRawFrontDocument,
                      "tokenRawBackDocument": backResult!.tokenRawBackDocument,
                      "documentData":
                          frontResult!
                              .documentData, // o backResult dependiendo del lado que tenga info
                      "tokenOCR": frontResult!.tokenOCR,
                      "faceImage": frontResult!.faceImage,
                      "tokenFaceImage": frontResult!.tokenFaceImage,
                    };

                    print("📤 Data to send to SaveBiometryData:\n${payload}");
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: color043371,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50.h(context)),
                ),
                child: const Text("Continue"),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _captureSide(bool isFront) async {
    final result = await SelphIDWidget.launchSelphIDCapture(isFront);

    result.fold(
      (error) {
        setState(() {
          errorMessage = "Capture failed. Please try again.";
        });
      },
      (data) {
        if (data.finishStatus.toInt() == 0) {
          setState(() {
            errorMessage = null;
            if (isFront) {
              frontCaptured = true;
            } else {
              backCaptured = true;
            }
          });
        } else {
          setState(() {
            errorMessage =
                data.errorDiagnostic.isNotEmpty
                    ? data.errorDiagnostic
                    : "An error occurred.";
          });
        }
      },
    );
  }
}
