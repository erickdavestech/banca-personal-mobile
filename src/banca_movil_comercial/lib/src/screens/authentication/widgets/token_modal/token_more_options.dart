import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class TokenMoreOptions extends StatefulWidget {
  final String serial;
  final String expirationDate;
  final VoidCallback onBack;

  const TokenMoreOptions({
    required this.serial,
    required this.expirationDate,
    required this.onBack,
    super.key,
  });

  @override
  State<TokenMoreOptions> createState() => _TokenMoreOptionsState();
}

class _TokenMoreOptionsState extends State<TokenMoreOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modal header
        Row(
          children: [
            IconButton(
              onPressed: widget.onBack,
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w(context),
                color: color07355E,
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
            Text(
              context.lang.tokenOptions,
              style: TextStyle(
                fontSize: 16.w(context),
                fontWeight: FontWeight.w700,
                color: color07355E,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h(context)),

        // Serial
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.lang.serial,
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeight.bold,
                color: color07355E,
              ),
            ),
            SizedBox(width: 12.w(context)),
            Text(
              widget.serial,
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeight.w400,
                color: color506578,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h(context)),

        // Expiration Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.lang.expiration,
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeight.bold,
                color: color07355E,
              ),
            ),
            SizedBox(width: 12.w(context)),
            Text(
              widget.expirationDate,
              style: TextStyle(
                fontSize: 14.w(context),
                fontWeight: FontWeight.w400,
                color: color506578,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h(context)),

        // Uninstall Token Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            // TODO: Implement Uninstall Token functionality
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorF2794C.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20.h(context),
                horizontal: 20.w(context),
              ),
              elevation: 0,
            ),
            child: Text(
              context.lang.uninstallToken,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.w(context),
                fontWeight: FontWeight.w400,
                color: colorF2794C,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h(context)),

        // Token disclaimer
        Padding(
          padding: EdgeInsets.only(top: 15.h(context), bottom: 10.h(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 18.w(context), color: color506578),
              SizedBox(width: 4.w(context)),
              Expanded(
                child: Text(
                  context.lang.tokenWarning,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 12.w(context), color: color506578),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Divider(color: color07355E.withOpacity(.12), thickness: 1),
        ),
      ],
    );
  }
}
