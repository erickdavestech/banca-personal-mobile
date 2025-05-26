import 'package:banca_movil_comercial/src/bloc/biometria_bloc/biometric_bloc.dart';
import 'package:banca_movil_comercial/src/screens/authentication/widgets/biometric_tips_box.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceCapturePage extends StatelessWidget {
  const FaceCapturePage({super.key});
  static const String routeName = '/FaceCapturePage';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiometricBloc(),
      child: BlocBuilder<BiometricBloc, BiometricState>(
        builder: (context, state) {
          final bloc = context.read<BiometricBloc>();

          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: color043371),
              title: const Text(
                "Face Capture",
                style: TextStyle(
                  color: color043371,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
            ),
            body: Center(
              child: SizedBox(
                width: isTablet ? 400.w(context) : double.infinity,
                child: _buildContent(context, state, bloc),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    BiometricState state,
    BiometricBloc bloc,
  ) {
    return Padding(
      padding: EdgeInsets.all(20.w(context)),
      child: Column(
        children: [
          SizedBox(height: 20.h(context)),
          Expanded(child: Image.asset('assets/images/face_instruction.png')),
          SizedBox(height: 16.h(context)),
          Text(
            "Look directly at the camera and align your face inside the frame. "
            "Use a well-lit environment for a better result.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.w(context), color: color1C274C),
          ),
          SizedBox(height: 24.h(context)),
          const BiometricTipsBox(),
          SizedBox(height: 12.h(context)),
          Row(
            children: [
              Checkbox(value: true, onChanged: null, activeColor: color043371),
              Expanded(
                child: Text(
                  "I accept the terms and conditions.",
                  style: TextStyle(fontSize: 13.w(context), color: color506578),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h(context)),
          if (state is FaceCaptureInProgress)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () => bloc.add(StartFaceCaptureEvent()),
              style: ElevatedButton.styleFrom(
                backgroundColor: color005199, // fondo
                foregroundColor: Colors.white, // texto
                minimumSize: Size(double.infinity, 50.h(context)), // opcional
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12.w(context),
                  ), // opcional
                ),
              ),
              child: Text("Take Photo"),
            ),

          SizedBox(height: 16.h(context)),
          if (state is FaceCaptureFailure)
            Text(
              state.message,
              style: TextStyle(color: colorCE1228, fontSize: 13.w(context)),
            ),
        ],
      ),
    );
  }
}
