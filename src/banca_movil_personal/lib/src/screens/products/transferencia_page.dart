import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/bloc/login_bloc/login_bloc.dart';
import 'package:ca_mobile/src/bloc/transaction_bloc/transaction_bloc.dart';

import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/main/list_products_transfer_screen.dart';
import 'package:ca_mobile/src/screens/main/tabs_screen.dart';
import 'package:ca_mobile/src/screens/products/transfer_completed_screen.dart';
import 'package:ca_mobile/src/screens/products/widgets/confirm_transfer_content.dart';
import 'package:ca_mobile/src/screens/products/widgets/custom_modal.dart';
import 'package:ca_mobile/src/screens/products/widgets/validatior_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferBetweenAccountsScreen extends StatefulWidget {
  static const String routeName = '/transfer-between-accounts';

  const TransferBetweenAccountsScreen({super.key});

  @override
  State<TransferBetweenAccountsScreen> createState() =>
      _TransferBetweenAccountsScreenState();
}

class _TransferBetweenAccountsScreenState
    extends State<TransferBetweenAccountsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<TransactionBloc>().add(InitTransaction());
    super.initState();
  }

  Future<void> showCancelTransferDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                    color: color07355E),
              ),
            ],
          ),
          // Contenido explicativo
          content: Text(
            'Al cancelar la transferencia, los cambios realizados no se guardarán.',
            style: TextStyle(
              fontSize: 16.w(context),
              color: color07355E,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(137.w(context), 50.h(context)),
                backgroundColor: color005199,
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

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await showCancelTransferDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          leading: IconButton(
            onPressed: () async {
              // context.pop();
              await showCancelTransferDialog(context);
            },
            icon: Image(
              width: 25.w(context),
              image: AssetImage(AppImages.backBtn),
            ),
          ),
          title: Text(
            text.transfersBetweenAccounts,
            style: TextStyle(
              fontSize: 16.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color06243E,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: colorD5D5D5,
              thickness: 1,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: _TransferForm(
          formKey: _formKey,
          amountController: _amountController,
          descriptionController: _descriptionController,
        ),
      ),
    );
  }
}

// Formulario principal
class _TransferForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController descriptionController;

  const _TransferForm({
    required this.formKey,
    required this.amountController,
    required this.descriptionController,
  });
  @override
  Widget build(BuildContext context) {
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
                  balance: num.parse(state.sourceProduct?.available ?? '0')
                      .priceFormat,
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
            text.destinationProduct,
            style: TextStyle(
              fontSize: 14.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color080C3A,
            ),
          ),
          SizedBox(height: 6.h(context)),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state.destinationProduct != null) {
                return ProductCardWidget(
                  title: '${state.destinationProduct?.description}',
                  accountNumber: "${state.destinationProduct?.accountNumber}",
                  balance: num.parse(state.destinationProduct?.available ?? '0')
                      .priceFormat,
                  iconPath: "${state.destinationProduct?.iconPath}",
                  onTap: () {
                    context.read<TransactionBloc>().add(ClearSelectedEvent());
                    context.pushNamed(
                      ProductsTransferScreen.routeName,
                      arguments: false,
                    );
                  },
                );
              }
              return _CuentaOrigenSelector(
                title: text.destinationProduct,
                description: text.selectDestinationProduct,
                onTap: () {
                  context.read<TransactionBloc>().add(ClearSelectedEvent());
                  context.pushNamed(
                    ProductsTransferScreen.routeName,

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
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return text.amountRequired;
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return text.amountInvalid;
              }

              final available = context
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
              prefixStyle: TextStyle(
                fontSize: 24.w(context),
                color: color07355E.withOpacity(.26),
              ),
              hintText: '0.00',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefix: Text("B/. "),
              isDense: true,
              hintStyle: TextStyle(
                fontSize: 24.w(context),
                color: color07355E.withOpacity(.26),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color005199, width: 1.3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color005199, width: 1.3),
              ),
            ),
            style: TextStyle(
              fontSize: 24.w(context),
              color: color005199,
              fontWeight: FontWeightEnum.Medium.fWTheme,
            ),
          ),

          SizedBox(height: 24.h(context)),
          _DescripcionInputField(descriptionController: descriptionController),
          SizedBox(height: 5.h(context)),
          _ProgramarTransaccionCheckbox(),
          SizedBox(height: 60.h(context)),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: state.destinationProduct == null ||
                            state.destinationProduct == null
                        ? WidgetStatePropertyAll(color07355E26)
                        : null,
                    foregroundColor: state.destinationProduct == null ||
                            state.destinationProduct == null
                        ? WidgetStatePropertyAll(color506578)
                        : null),
                onPressed: state.destinationProduct == null ||
                        state.destinationProduct == null
                    ? null
                    : () async {
                        final validate = formKey.currentState?.validate();
                        final products = context.read<TransactionBloc>().state;

                        if (validate == false) return;
                        if (amountController.text.isNullOrEmpty) return;
                        if (products.sourceProduct == null) return;
                        if (products.destinationProduct == null) return;

                        final user =
                            context.read<LoginBloc>().state as LoginSuccess;

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => CustomModal(
                            child: ConfirmTransferContent(
                              monto: num.parse(amountController.text.trim()),
                              cuentaOrigenNombre:
                                  "${products.sourceProduct?.description}",
                              cuentaOrigenNumero:
                                  "${products.sourceProduct?.accountNumber}",
                              cuentaDestinoNombre: user.user.user?.name ?? '',
                              cuentaDestinoNumero:
                                  "${products.destinationProduct?.accountNumber}",
                              cuentaDestinoDescripcion:
                                  "${products.destinationProduct?.description}",
                              descripcion: descriptionController.text.trim(),
                              onEnviar: () async {
                                try {
                                  context.pop();

                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    enableDrag: false,
                                    builder: (_) => ValidandoTokenLoader(
                                      title: text.makingTransfer,
                                    ),
                                  );

                                  await TransferController.transferFunds(
                                    destinationAccount:
                                        "${products.destinationProduct?.accountNumber}",
                                    originAccount:
                                        "${products.sourceProduct?.accountNumber}",
                                    amount: amountController.text.trim(),
                                    description:
                                        descriptionController.text.trim(),
                                  );

                                  context.pop();
                                  await Future.delayed(Durations.long1);

                                  context.pushNamedAndRemoveUntil(
                                    TransferCompletedScreen.routeName,
                                    arguments: {
                                      'amount': amountController.text.trim(),
                                      'sourceName':
                                          "${products.sourceProduct?.name}",
                                      'sourceAccount':
                                          "*${products.sourceProduct?.accountNumber?.obtenerUltimosDigitos}",
                                      'sourceDescription':
                                          "${products.sourceProduct?.description}",
                                      'destinationName':
                                          user.user.user?.name ?? '',
                                      'destinationAccount':
                                          "*${products.destinationProduct?.accountNumber?.obtenerUltimosDigitos}",
                                      'destinationDescription':
                                          "${products.destinationProduct?.description}",
                                      'description':
                                          descriptionController.text.trim(),
                                    },
                                  );
                                } on Exception catch (e) {
                                  context.pop();
                                  showFailTransferDialog(
                                    context,
                                    message: e
                                        .toString()
                                        .replaceAll("Exception: ", ""),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                child: Text(text.productTransferButton),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> showFailTransferDialog(BuildContext context, {String? message}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                    color: color07355E),
              ),
            ],
          ),
          // Contenido explicativo
          content: Text(
            message ?? 'Por favor, revisa tu conexión o intenta nuevamente',
            style: TextStyle(
              fontSize: 16.w(context),
              color: color07355E,
            ),
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
          style: TextStyle(
            fontSize: 14.w(context),
            color: color506578,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: colorD5D5D5),
        onTap: onTap,
      ),
    );
  }
}

// Monto
// class _MontoInputField extends StatelessWidget {
//   const _MontoInputField();

//   @override
//   Widget build(BuildContext context) {
//     final text = AppLocalizations.of(context)!;
//     // final controller = TextEditingController();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text.amountLabel,
//           style: TextStyle(
//             fontSize: 14.w(context),
//             fontWeight: FontWeightEnum.SemiBold.fWTheme,
//             color: color080C3A,
//           ),
//         ),
//         SizedBox(height: 6.h(context)),
//         TextFormField(
//           // controller: controller,
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return text.amountRequired;
//             }
//             final amount = double.tryParse(value);
//             if (amount == null || amount <= 0) {
//               return text.amountInvalid;
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//             // prefixText: "B/. ",
//             prefixStyle: TextStyle(
//               fontSize: 24.w(context),
//               color: color07355E.withOpacity(.26),
//             ),

//             hintText: '0.00',

//             floatingLabelBehavior: FloatingLabelBehavior.always,

//             prefix: Text("B/. "),
//             isDense: true,
//             // prefixIconConstraints: BoxConstraints(
//             //   minWidth: 0,
//             //   minHeight: 0,
//             // ),
//             hintStyle: TextStyle(
//               fontSize: 24.w(context),
//               color: color07355E.withOpacity(.26),
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: color005199, width: 1.3),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: color005199, width: 1.3),
//             ),
//           ),
//           style: TextStyle(
//             fontSize: 24.w(context),
//             color: color005199,
//             fontWeight: FontWeightEnum.Medium.fWTheme,
//           ),
//         ),
//       ],
//     );
//   }
// }

// Descripción
class _DescripcionInputField extends StatelessWidget {
  const _DescripcionInputField({required this.descriptionController});

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text.descriptionOptional
              .replaceAll("(opcional)", "")
              .replaceAll("(optional)", ""),
          style: TextStyle(
            fontSize: 14.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
            color: color06243E,
          ),
        ),
        SizedBox(height: 6.h(context)),
        Column(
          children: [
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              maxLength: 45,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return text.amountRequired;
                }
                return null;
              },
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 16.w(context),
                  color: Colors.grey,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontSize: 16.w(context),
                color: color06243E,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h(context)),
                child: Text(
                  text.maxCharacters,
                  style: TextStyle(
                    fontSize: 12.w(context),
                    color: color506578,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
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
              style: TextStyle(
                fontSize: 12.w(context),
                color: color506578,
              ),
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

// Checkbox programar transacción
class _ProgramarTransaccionCheckbox extends StatefulWidget {
  const _ProgramarTransaccionCheckbox();

  @override
  State<_ProgramarTransaccionCheckbox> createState() =>
      _ProgramarTransaccionCheckboxState();
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      activeColor: color005199,
      side: BorderSide(color: colorD5D5D5, width: 1.3),
      visualDensity: VisualDensity.compact,
    );
  }
}
