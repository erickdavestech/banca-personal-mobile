// ignore_for_file: deprecated_member_use

import 'package:banca_movil_comercial/src/bloc/beneficiarios_bloc/beneficiarios_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/screens/main/list_products_transfer_screen.dart';
import 'package:banca_movil_comercial/src/screens/main/tabs_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/list_beneficiario_transfer_screen.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/confirm_transfer_interbank.dart';
import 'package:banca_movil_comercial/src/screens/products/widgets/custom_modal.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterbankScreen extends StatefulWidget {
  static const String routeName = '/Interbank-transfer';

  const InterbankScreen({super.key});

  @override
  State<InterbankScreen> createState() => _InterbankScreenState();
}

class _InterbankScreenState extends State<InterbankScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<TransactionBloc>().add(InitTransaction());
    context.read<BeneficiariosBloc>().add(InitBeneficiario());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            showCancelTransferDialog(context);
          },
          icon: Image(
            width: 25.w(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
        title: Text(
          text.bankTransfer,
          style: TextStyle(
            fontSize: 16.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
            color: color06243E,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: colorD5D5D5, thickness: 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: _TransferForm(formKey: _formKey),
    );
  }
}

// Formulario principal
class _TransferForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _TransferForm({required this.formKey});
  @override
  Widget build(BuildContext context) {
    final isSourceSelected =
        context.watch<TransactionBloc>().state.sourceProduct != null;
    final isBeneficiarySelected =
        context.watch<BeneficiariosBloc>().state.destinationBeneficiario !=
        null;
    final text = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w(context),
          vertical: 16.h(context),
        ),
        children: [
          Text(
            text.accountOrigin,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color080C3A,
            ),
          ),
          SizedBox(height: 6.h(context)),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state.sourceProduct != null) {
                return ProductCardWidget(
                  title: '${state.sourceProduct?.description}',
                  accountNumber: "${state.sourceProduct?.accountNumber}",
                  balance:
                      num.parse(
                        state.sourceProduct?.available ?? '0',
                      ).priceFormat,
                  iconPath:
                      "${state.sourceProduct?.iconPath}", // Usa el asset correcto aquí
                  onTap: () {
                    context.read<TransactionBloc>().add(ClearSelectedEvent());
                    context.pushNamed(
                      ProductsTransferScreen.routeName,
                      arguments: true,
                    );
                  },
                );
              }
              return _CuentaOrigenSelector(
                title: text.accountOrigin,
                description: text.selectAccountOrigin,
                onTap: () {
                  context.read<TransactionBloc>().add(ClearSelectedEvent());
                  context.pushNamed(
                    ProductsTransferScreen.routeName,

                    /// Detect if the user is selecting the origin account
                    arguments: true,
                  );
                },
              );
            },
          ),
          SizedBox(height: 24.h(context)),
          Text(
            text.beneficiary,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color080C3A,
            ),
          ),
          SizedBox(height: 6.h(context)),
          BlocBuilder<BeneficiariosBloc, BeneficiariosState>(
            builder: (context, state) {
              if (state.destinationBeneficiario != null) {
                return BeneficiarioCardWidget(
                  title: '${state.destinationBeneficiario?.nombre}',
                  description: "${state.destinationBeneficiario?.banco}",
                  account: "${state.destinationBeneficiario?.cuenta}",
                  accountType: "${state.destinationBeneficiario?.tipoCuenta}",
                  onTap: () {
                    context.read<BeneficiariosBloc>().add(
                      ClearBeneficiarioSelectionEvent(),
                    );
                    context.pushNamed(
                      BeneficiariosTransferScreen.routeName,
                      arguments: true,
                    );
                  },
                );
              }
              return _CuentaOrigenSelector(
                title: text.beneficiary,
                description: " ${text.selectBeneficiary}",
                onTap: () {
                  context.read<BeneficiariosBloc>().add(
                    ClearBeneficiarioSelectionEvent(),
                  );
                  context.pushNamed(
                    BeneficiariosTransferScreen.routeName,
                    //  ValidandoTokenLoader.routeName,

                    /// Detect if the user is selecting the origin account
                    arguments: false,
                  );
                },
              );
            },
          ),
          SizedBox(height: 24.h(context)),
          // _MontoInputField(),
          Text(
            text.amountLabel,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color080C3A,
            ),
          ),
          SizedBox(height: 6.h(context)),
          TextFormField(
            // controller: controller,
            enableInteractiveSelection: false,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return text.amountRequired;
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return text.amountInvalid;
              }

              final available =
                  context
                      .read<TransactionBloc>()
                      .state
                      .sourceProduct
                      ?.available;

              if (amount > double.parse(available ?? '0')) {
                return text.amountExceedsLimit;
              }

              return null;
            },
            decoration: InputDecoration(
              // prefixText: "B/. ",
              prefixStyle: TextStyle(
                fontSize: 24.w(context),
                color: color07355E.withOpacity(.26),
              ),

              hintText: '0.00',

              floatingLabelBehavior: FloatingLabelBehavior.always,

              prefix: Text("B/. "),
              isDense: true,
              // prefixIconConstraints: BoxConstraints(
              //   minWidth: 0,
              //   minHeight: 0,
              // ),
              hintStyle: TextStyle(
                fontSize: 24.w(context),
                color: color07355E.withOpacity(.26),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color043371, width: 1.3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color043371, width: 1.3),
              ),
            ),
            style: TextStyle(
              fontSize: 24.w(context),
              color: color043371,
              fontWeight: FontWeightEnum.Medium.fWTheme,
            ),
          ),
          SizedBox(height: 24),

          ACHOptionSelector(),
          SizedBox(height: 24.h(context)),
          _DescripcionInputField(),
          // SizedBox(height: 5.h(context)),
          // _ProgramarTransaccionCheckbox(),
          SizedBox(height: 60.h(context)),
          ElevatedButton(
            onPressed:
                (isSourceSelected && isBeneficiarySelected)
                    ? () {
                      final validate = formKey.currentState?.validate();
                      if (validate == false) return;

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder:
                            (_) => CustomModal(
                              child: ConfirmTransferInterbankContent(
                                monto: 450.00,
                                cuentaOrigenNombre: "Ahorro para boda",
                                cuentaOrigenNumero: "207265344",
                                cuentaDestinoNombre: "Melanie Caraballo",
                                cuentaDestinoNumero: "26546500",
                                descripcion: "Pago mensual",
                                onEnviar: () {
                                  // Aquí tu lógica: BLoC o llamada
                                  Navigator.pop(context); // Cierra el modal
                                },
                              ),
                            ),
                      );
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, 50.h(context)),
              backgroundColor: color043371, // color activo
              disabledBackgroundColor: color07355E.withOpacity(.26),
            ),
            child: Text(text.productTransferButton),
          ),
        ],
      ),
    );
  }
}

// Cuenta origen
class _CuentaOrigenSelector extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _CuentaOrigenSelector({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorD5D5D5, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        minTileHeight: 50.h(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w(context)),
        title: Text(
          description,
          style: TextStyle(fontSize: 14.w(context), color: color506578),
        ),
        trailing: Icon(Icons.chevron_right, color: colorD5D5D5),
        onTap: onTap,
      ),
    );
  }
}

// Descripción
class _DescripcionInputField extends StatelessWidget {
  const _DescripcionInputField();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text.descriptionOptional,
          style: TextStyle(
            fontSize: 14.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
            color: color06243E,
          ),
        ),
        SizedBox(height: 6.h(context)),
        Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 4,
              maxLength: 45,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 16.w(context),
                  color: Colors.grey,
                ),
                counterText: '',
              ),
              style: TextStyle(fontSize: 16.w(context), color: color06243E),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h(context)),
                child: Text(
                  text.maxCharacters,
                  style: TextStyle(fontSize: 12.w(context), color: color506578),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> showCancelTransferDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // Título con imagen e ícono
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 95.w(context),
              height: 95.h(context),
              child: Image.asset(AppImages.alertClose),
            ),
            SizedBox(height: 18.h(context)),
            Text(
              '¿Desea cancelar la transferencia actual?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color07355E,
              ),
            ),
          ],
        ),
        // Contenido explicativo
        content: Text(
          'Al cancelar la transferencia, los cambios realizados no se guardarán.',
          style: TextStyle(fontSize: 16.w(context), color: color07355E),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              context.pushNamedAndRemoveUntil(TabsScreen.routeName);
            },
            style: OutlinedButton.styleFrom(
              fixedSize: Size(137.w(context), 50.h(context)),
            ),
            child: Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 12.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color516578,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(137.w(context), 50.h(context)),
              backgroundColor: color043371,
            ),
            child: Text(
              'Volver',
              style: TextStyle(
                fontSize: 12.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showFailTransferDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // Título con imagen e ícono
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 71.w(context),
              height: 71.h(context),
              child: Image.asset(AppImages.alertFail),
            ),
            SizedBox(height: 18.h(context)),
            Text(
              'Ocurrió un error al procesar la transferencia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color07355E,
              ),
            ),
          ],
        ),
        // Contenido explicativo
        content: Text(
          'Por favor, revisa tu conexión o intenta nuevamente',
          style: TextStyle(fontSize: 16.w(context), color: color07355E),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Reintentar',
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class ProductCardWidget extends StatelessWidget {
  final String title;
  final String accountNumber;
  final String balance;
  final String iconPath;
  final VoidCallback onTap;

  const ProductCardWidget({
    required this.title,
    required this.accountNumber,
    required this.balance,
    required this.iconPath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorD5D5D5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          // vertical: 12.h(context),
          horizontal: 12.w(context),
        ),
        leading: Container(
          padding: EdgeInsets.all(8.w(context)),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.asset(
            iconPath,
            width: 37.w(context),
            height: 36.h(context),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: $accountNumber',
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color06243E,
              ),
            ),
            // SizedBox(height: 4.h(context)),
            Text(
              'Balance disponible:',
              style: TextStyle(fontSize: 12.w(context), color: color506578),
            ),
            Text(
              'B/. $balance',
              style: TextStyle(
                fontSize: 16.w(context),
                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                color: color06243E,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: colorD5D5D5),
      ),
    );
  }
}

class BeneficiarioCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String account;
  final String accountType;
  final VoidCallback onTap;

  const BeneficiarioCardWidget({
    required this.title,
    required this.description,
    required this.account,
    required this.accountType,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorD5D5D5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w(context)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
            color: color06243E,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h(context)),
            Row(
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.h(context),
                    fontWeight: FontWeightEnum.Medium.fWTheme,
                    color: color506578,
                  ),
                ),
                SizedBox(width: 5.w(context)),
                Container(height: 10.h(context), width: 1, color: color506578),
                SizedBox(width: 7.w(context)),
                Text(
                  "$account - $accountType",
                  style: TextStyle(
                    color: color506578,
                    fontWeight: FontWeightEnum.Medium.fWTheme,
                    fontSize: 14.w(context),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: colorD5D5D5),
      ),
    );
  }
}

// Checkbox programar transacción
class _ProgramarTransaccionCheckbox extends StatefulWidget {
  const _ProgramarTransaccionCheckbox();

  @override
  State<_ProgramarTransaccionCheckbox> createState() =>
      _ProgramarTransaccionCheckboxState();
}

class ACHOptionSelector extends StatefulWidget {
  const ACHOptionSelector({super.key});

  @override
  State<ACHOptionSelector> createState() => _ACHOptionSelectorState();
}

class _ACHOptionSelectorState extends State<ACHOptionSelector> {
  String selected = 'ACH Xpress';

  Widget _buildOption(String label) {
    final isSelected = selected == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        width: double.infinity,
        // height: 50.h(context),
        decoration: BoxDecoration(
          border: Border.all(color: color07355E.withAlpha(26), width: 2),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? color043371 : color506578,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color043371 : color506578,
                fontWeight: FontWeightEnum.Medium.fWTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildOption("ACH Xpress")),
        const SizedBox(width: 30),
        Expanded(child: _buildOption("ACH Directo")),
      ],
    );
  }
}

class _ProgramarTransaccionCheckboxState
    extends State<_ProgramarTransaccionCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        spacing: 6.w(context),
        children: [
          Image(
            image: AssetImage(AppImages.scheduleTransaction),
            width: 24.w(context),
            height: 24.h(context),
          ),
          Text(
            text.scheduleTransaction,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color06243E,
            ),
          ),
        ],
      ),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() => isChecked = !isChecked);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      activeColor: color043371,
      side: BorderSide(color: colorD5D5D5, width: 1.3),
      visualDensity: VisualDensity.compact,
    );
  }
}
