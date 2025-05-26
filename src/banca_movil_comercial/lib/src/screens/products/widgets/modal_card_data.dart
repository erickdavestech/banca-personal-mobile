// ignore_for_file: deprecated_member_use

import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

void showCardDataModal(BuildContext context) {
  final text = AppLocalizations.of(context)!;
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(top: 10.h(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          /*boxShadow: [
            BoxShadow(
              color: Color(0x00519910),
              blurRadius: 15,
              spreadRadius: 10,
              offset: Offset(4, 0)
            )
          ],*/
        ),
        child: SafeArea(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/images/round-alt-arrow-left-svgrepo-com.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          text.cardInfo,
                          style: TextStyle(
                            fontSize: 16.w(context),
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF07355E),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Color(0xFFF9FAFB),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      width: 382,
                      height: 186,
                      decoration: BoxDecoration(
                        color: Color(0xFF005199),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            right: -150,
                            child: Container(
                              width: 240,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -25,
                            right: -110,
                            child: Container(
                              width: 260,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.1),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/caAppBar_logo.png',
                                      width: 36.92,
                                      height: 36.69,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      text.debitCard,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 15,
                            child: Image.asset(
                              'assets/images/mastercard.png',
                              fit: BoxFit.contain,
                              width: 66,
                            ),
                          ),
                          Positioned(
                            top: 25,
                            right: 15,
                            child: Image.asset(
                              'assets/images/contactless.png',
                              fit: BoxFit.contain,
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    _readOnlyField(
                      context,
                      label: text.cardNumber,
                      value: "**** **** **** 2048",
                    ),
                    _readOnlyField(
                      context,
                      label: text.cardName,
                      value: "Melanie Caraballo",
                    ),
                    _readOnlyField(
                      context,
                      label: text.cardExpiration,
                      value: "04/27",
                    ),
                    _readOnlyField(context, label: text.cardCvv, value: "786"),
                    _readOnlyField(context, label: text.cardPin, value: "0678"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _readOnlyField(
  BuildContext context, {
  required String label,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 24.h(context)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.w(context),
            color: Color(0xFF07355E),
          ),
        ),
        SizedBox(height: 9.h(context)),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F7F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            readOnly: true,
            controller: TextEditingController(text: value),
            style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF5F7F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFFE0E0E0)),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
