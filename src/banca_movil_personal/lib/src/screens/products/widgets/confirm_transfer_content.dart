import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/products/widgets/custom_slide_button.dart';
import 'package:flutter/material.dart';

class ConfirmTransferContent extends StatelessWidget {
  final num monto;
  final String cuentaOrigenNombre;
  final String cuentaOrigenNumero;
  final String cuentaDestinoNombre;
  final String cuentaDestinoNumero;
  final String descripcion;
  final VoidCallback onEnviar;
  final String cuentaDestinoDescripcion;

  const ConfirmTransferContent({
    super.key,
    required this.monto,
    required this.cuentaOrigenNombre,
    required this.cuentaOrigenNumero,
    required this.cuentaDestinoNombre,
    required this.cuentaDestinoNumero,
    required this.descripcion,
    required this.onEnviar,
    required this.cuentaDestinoDescripcion,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeaderSection(onClose: () => Navigator.pop(context)),
        _IconAndAmountSection(monto: monto),
        SizedBox(height: 13.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: _AccountInfoCard(
            tituloIzquierda: text.accountOrigin,
            contenidoDerecha: [
              Text(
                cuentaOrigenNombre,
                style: TextStyle(
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color07355E,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                cuentaOrigenNumero,
                style: TextStyle(
                  fontSize: 13.w(context),
                  color: color003362,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: _AccountInfoCard(
            tituloIzquierda: text.destinationProduct,
            contenidoDerecha: [
              Text(
                cuentaDestinoDescripcion,
                style: TextStyle(
                  fontSize: 12.w(context),
                  color: color506578,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                cuentaDestinoNombre,
                style: TextStyle(
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color003362,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                cuentaDestinoNumero,
                style: TextStyle(
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color003362,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        SizedBox(height: 17.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: _AccountInfoCard(
            tituloIzquierda: "${text.descriptionOptional}:",
            contenidoDerecha: [
              Text(
                descripcion,
                style: TextStyle(
                  fontSize: 14.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color003362,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        SizedBox(height: 17.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: _DisclaimerSection(),
        ),
        SizedBox(height: 57.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: CustomSlideButton(
            onSlideComplete: onEnviar,
            text: text.slideToSend,
          ),
        ),
        SafeArea(
          child: SizedBox(
            height: MediaQuery.paddingOf(context).bottom,
          ),
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final VoidCallback onClose;

  const _HeaderSection({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          width: 48.w(context),
          height: 4.h(context),
          margin: EdgeInsets.only(bottom: 12.h(context)),
          decoration: BoxDecoration(
            color: colorE0E0E0,
            borderRadius: BorderRadius.circular(4.w(context)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text.confirmTransfer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.w(context),
                    fontWeight: FontWeightEnum.Bold.fWTheme,
                    color: color06243E,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w(context)),
                  child: Icon(
                    Icons.close,
                    size: 20.w(context),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16.h(context)),
        const Divider(
          color: colorE0E0E0,
          height: 0,
        ),
        SizedBox(height: 20.h(context)),
      ],
    );
  }
}

class _IconAndAmountSection extends StatelessWidget {
  final num monto;

  const _IconAndAmountSection({required this.monto});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Ícono PNG dentro de un círculo azul
        Container(
          width: 60.w(context),
          height: 60.w(context),
          decoration: BoxDecoration(
            color: color007AFF, // Azul corporativo
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              AppImages.transferIcon, // <- Ajusta el path según tu estructura
              width: 217.w(context),
              height: 412.w(context),
              color: colorF9FAFB,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 16.h(context)),

        Text(
          text.amountToTransfer,
          style: TextStyle(
            fontSize: 14.w(context),
            color: color06243E,
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
          ),
        ),

        Text(
          "B/. ${monto.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 24.w(context),
            fontWeight: FontWeightEnum.Bold.fWTheme,
            color: color005199,
          ),
        ),
      ],
    );
  }
}

class _AccountInfoCard extends StatelessWidget {
  final String tituloIzquierda;
  final List<Widget> contenidoDerecha;

  const _AccountInfoCard({
    required this.tituloIzquierda,
    required this.contenidoDerecha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 12.h(context),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorE0E0E0,
        ),
        borderRadius: BorderRadius.circular(12.w(context)),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Texto izquierdo (label)
          Expanded(
            child: Text(
              tituloIzquierda,
              style: TextStyle(
                fontSize: 12.w(context),
                color: color506578,
              ),
            ),
          ),

          // Contenido derecho (alineado arriba a la derecha)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: contenidoDerecha,
            ),
          )
        ],
      ),
    );
  }
}

class _DisclaimerSection extends StatelessWidget {
  const _DisclaimerSection();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        // padding: EdgeInsets.all(0), // El padding irá solo en el texto
        decoration: BoxDecoration(
          color: colorF1F8FF, // Fondo azul claro
          borderRadius: BorderRadius.circular(8.w(context)),
          border: Border.all(
            color: colorE0E0E0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ceja azul lateral izquierda
            Container(
              width: 4.w(context),
              decoration: BoxDecoration(
                color: color005199,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            SizedBox(width: 8.w(context)),

            // Texto
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h(context),
                  horizontal: 8.w(context),
                ),
                child: Text(
                  text.verifyTransactionData,
                  style: TextStyle(
                    fontSize: 12.w(context),
                    color: color06243E,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
