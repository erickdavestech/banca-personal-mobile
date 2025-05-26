
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/bloc/beneficiarios_bloc/beneficiarios_bloc.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/models/beneficiario_model.dart';
import 'package:ca_mobile/src/screens/products/interbank_transfer.dart';
import 'package:ca_mobile/src/screens/products/list_beneficiario_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ...importaciones existentes...

import 'package:flutter/services.dart'; // Asegúrate de tener esto

class CreateBeneficiaryScreen extends StatefulWidget {
  static const String routeName = '/create-beneficiary';
  const CreateBeneficiaryScreen({super.key});

  @override
  State<CreateBeneficiaryScreen> createState() =>
      _CreateBeneficiaryScreenState();
}

class _CreateBeneficiaryScreenState extends State<CreateBeneficiaryScreen> {
  final _formKey = GlobalKey<FormState>();

  String? bancoSeleccionado;
  String? tipoProductoSeleccionado;
  final TextEditingController numeroProductoController =
      TextEditingController();
  final TextEditingController nombreBeneficiarioController =
      TextEditingController();
  final TextEditingController correoController = TextEditingController();

  bool get isFormValid =>
      bancoSeleccionado != null &&
      tipoProductoSeleccionado != null &&
      numeroProductoController.text.isNotEmpty &&
      nombreBeneficiarioController.text.isNotEmpty;

  void _onChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    numeroProductoController.addListener(_onChanged);
    nombreBeneficiarioController.addListener(_onChanged);
  }

  @override
  void dispose() {
    numeroProductoController.dispose();
    nombreBeneficiarioController.dispose();
    correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    final List<String> bancos = [
      "Banco Viejo",
      "Banco Nuevo",
    ];

    final List<String> tiposProductos = [
      "Cuenta corriente",
      "Cuenta de ahorros",
      "Tarjeta de crédito",
      "Préstamo",
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showCancelDialog(context);
          },
          icon: Image(
            width: 22.w(context),
            height: 22.h(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
        title: Text(
          text.createBeneficiary,
          style: TextStyle(
            fontSize: 16.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
            color: color06243E,
          ),
        ),
        toolbarHeight: 100.h(context),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(color: colorD5D5D5, thickness: 1),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w(context)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 16.h(context)),
                _buildDropdownField(
                  label: text.createBeneficiaryDropdownTitle,
                  hint: text.createBeneficiaryDropdownHint,
                  value: bancoSeleccionado,
                  items: bancos,
                  onChanged: (val) => setState(() => bancoSeleccionado = val),
                ),
                SizedBox(height: 16.h(context)),
                _buildDropdownField(
                  label: text.createBeneficiaryDropdownType,
                  hint: text.createBeneficiaryDropdownSelectType,
                  value: tipoProductoSeleccionado,
                  items: tiposProductos,
                  onChanged: (val) =>
                      setState(() => tipoProductoSeleccionado = val),
                      
                ),
                SizedBox(height: 16.h(context)),
                _buildTextField(
                  text.createBeneficiaryNoProduct,
                  text.createBeneficiaryNoProduct,
                  numeroProductoController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 30,
                ),
                SizedBox(height: 16.h(context)),
                _buildTextField(
                  text.createBeneficiaryNameBeneficiary,
                  text.createBeneficiaryNameBeneficiary,
                  nombreBeneficiarioController,
                  maxLength: 35,
                ),
                SizedBox(height: 16.h(context)),
                _buildTextField(
                  '${text.createBeneficiaryMail} (${text.createBeneficiaryoptional})',
                  text.createBeneficiaryMail,
                  correoController,
                  maxLength: 35,
                ),
                SizedBox(height: 217.h(context)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            final nuevoBeneficiario = Beneficiarios(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              nombre: nombreBeneficiarioController.text,
                              banco: bancoSeleccionado!,
                              cuenta: numeroProductoController.text,
                              tipoCuenta: tipoProductoSeleccionado!,
                            );

                            final bloc = context.read<BeneficiariosBloc>();
                            bloc.add(AddAndSelectBeneficiarioEvent(
                                nuevoBeneficiario));
                            context.pushNamed(InterbankScreen.routeName);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isFormValid ? color005199 : color07355E26,
                      disabledBackgroundColor: color07355E26,
                    ),
                    child: Text(
                      text.createBeneficiaryButton,
                      style: TextStyle(
                        fontSize: 14.w(context),
                        color: isFormValid ? Colors.white : color506578,
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              fontSize: 14.w(context),
              color: color080C3A,
            )),
        SizedBox(height: 8.h(context)),
        DropdownButtonFormField<String>(
          value: value,
          icon: Image.asset(AppImages.downArrow, width: 15.w(context), height: 14.h(context),),
          hint: Text(hint,
              style: TextStyle(color: color506578, fontSize: 14.w(context))),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w(context), vertical: 10.h(context)),
          ),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TextStyle(fontSize: 14.h(context))),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

 Widget _buildTextField(
  String label,
  String hint,
  TextEditingController controller, {
  List<TextInputFormatter>? inputFormatters,
  keyboardType = TextInputType.text,
  int? maxLength,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
            fontSize: 14.w(context),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
          )),
      SizedBox(height: 8.h(context)),
      TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        
        buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: color506578,
            fontSize: 14.w(context),
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w(context), vertical: 10.h(context)),
        ),
      ),
    ],
  );
}

  Future<void> showCancelDialog(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
               text.createBeneficiaryAlert,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.h(context),
                    fontWeight: FontWeightEnum.SemiBold.fWTheme,
                    color: color07355E),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                context.pushNamedAndRemoveUntil(
                    BeneficiariosTransferScreen.routeName);
              },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(137.w(context), 50.h(context)),
              ),
              child: Text(
                text.dialogCancel,
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
                backgroundColor: color005199,
              ),
              child: Text(
                text.alertLogOutBack,
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
}
