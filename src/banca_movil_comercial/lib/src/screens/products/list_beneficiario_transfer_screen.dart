import 'dart:developer';

import 'package:banca_movil_comercial/src/bloc/beneficiarios_bloc/beneficiarios_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_comercial/src/models/beneficiario_model.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiariosTransferScreen extends StatelessWidget {
  static const String routeName = '/beneficiarios-transfer';
  BeneficiariosTransferScreen({super.key});

  final List<Beneficiarios> beneficiario = [
    Beneficiarios(
      id: "1",
      nombre: 'Adams Lapaix Castillo',
      banco: 'Banco Nuevo',
      cuenta: '123456789',
      tipoCuenta: 'Corriente',
    ),
    Beneficiarios(
      id: "2",
      nombre: 'Stalin Bienvenido Rivas López',
      banco: 'Banco Viejo',
      cuenta: '987654321',
      tipoCuenta: 'Corriente',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: Image(
            width: 22.w(context),
            height: 22.h(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
        title: Text(
          text.beneficiarySelection,
          style: TextStyle(fontSize: 16.w(context)),
        ),
        toolbarHeight: 100.h(context),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: colorD5D5D5, thickness: 1),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              margin: EdgeInsets.only(top: 18),
              width: 382.w(context),
              height: 55.h(context),
              decoration: BoxDecoration(color: color043371.withOpacity(.05)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text.search,
                    style: TextStyle(
                      color: color506578,
                      fontSize: 14.w(context),
                      fontWeight: FontWeightEnum.SemiBold.fWTheme,
                    ),
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage(AppImages.search),
                    width: 11.w(context),
                    height: 11.h(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children:
                  beneficiario
                      .map(
                        (beneficiario) => _productCard(context, beneficiario),
                      )
                      .toList(),
            ),
          ),
          BlocBuilder<BeneficiariosBloc, BeneficiariosState>(
            builder: (context, state) {
              Beneficiarios? selectedBeneficiario;

              selectedBeneficiario = state.selectedBeneficiario;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom,
                  left: 21.w(context),
                  right: 21.w(context),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: color0080F2.withOpacity(0.2),
                  ),
                  onPressed:
                      selectedBeneficiario == null
                          ? null
                          : () {
                            context.read<BeneficiariosBloc>().add(
                              GetBeneficiarioToTransferEvent(
                                selectedBeneficiario!,
                              ),
                            );
                            context.pop();
                          },
                  child: Text(
                    selectedBeneficiario == null
                        ? text.newBeneficiary
                        : text.select,
                    style:
                        selectedBeneficiario == null
                            ? TextStyle(
                              fontSize: 14.w(context),
                              color: color043371,
                              fontWeight: FontWeightEnum.SemiBold.fWTheme,
                            )
                            : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _productCard(BuildContext context, Beneficiarios beneficiario) {
    return BlocBuilder<BeneficiariosBloc, BeneficiariosState>(
      builder: (context, state) {
        Beneficiarios? selected;
        selected = state.selectedBeneficiario;

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 21.w(context),
              ).copyWith(top: 12.h(context)),
              child: GestureDetector(
                onTap: () {
                  log("message");
                  if (selected?.id == beneficiario.id) {
                    context.read<BeneficiariosBloc>().add(
                      ClearBeneficiarioSelectionEvent(),
                    );
                  } else {
                    context.read<BeneficiariosBloc>().add(
                      SelectBeneficiarioEvent(beneficiario),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color:
                          beneficiario.id == selected?.id
                              ? color043371
                              : colorDCE2E8,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        beneficiario.nombre,
                        style: TextStyle(
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                          fontSize: 12.0,
                          color: color06243E,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            beneficiario.banco,
                            style: TextStyle(
                              fontSize: 14.h(context),
                              fontWeight: FontWeightEnum.Medium.fWTheme,
                              color: color506578,
                            ),
                          ),
                          SizedBox(width: 5.w(context)),
                          Container(
                            height: 10.h(context),
                            width: 1,
                            color: color506578,
                          ),
                          SizedBox(width: 7.w(context)),
                          Text(
                            "${beneficiario.cuenta} - ${beneficiario.tipoCuenta}",
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
                ),
              ),
            ),
            if (beneficiario.id == selected?.id)
              Positioned(
                right: 13.w(context),
                top: 5.h(context),
                child: ColoredBox(
                  color: Colors.white,
                  child: Icon(
                    Icons.check_circle,
                    color: color043371,
                    size: 20.w(context),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
