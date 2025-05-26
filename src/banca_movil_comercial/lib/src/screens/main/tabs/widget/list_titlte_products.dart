import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String? date;
  final num amount;

  final Color color;
  final bool isCredit;
  const TransactionTile({
    super.key,
    required this.title,
    this.date,
    required this.amount,
    required this.color,
    this.isCredit = true,
  });

  @override
  Widget build(BuildContext context) {
    final textOnlyTitle = title.replaceAll(RegExp(r'\s*\d+$'), '');

    final String iconPath =
        isCredit
            ? AppImages.money_transactions_history_plus
            : AppImages.money_transactions_history_minus;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w(context)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            child: Image.asset(
              iconPath,
              width: 40.w(context),
              height: 40.h(context),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 20.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w(context)),
                        child: Text(
                          textOnlyTitle.capitalizeSentences,
                          style: TextStyle(
                            color: color07355E,
                            fontWeight: FontWeightEnum.Medium.fWTheme,
                            fontSize: 14.w(context),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'B/. ${amount.priceFormat}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeightEnum.SemiBold.fWTheme,
                        fontSize: 14.w(context),
                      ),
                    ),
                    SizedBox(width: 15.w(context)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: color1C274C,
                      size: 12.w(context),
                    ),
                    SizedBox(width: 20.w(context)),
                  ],
                ),
                SizedBox(height: 4.h(context)),
                if (date != null)
                  Text(
                    // DateFormat.yMMMd().format(date!).capitalize,
                    date ?? "",
                    style: TextStyle(
                      color: color51708E,
                      fontSize: 12.w(context),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
