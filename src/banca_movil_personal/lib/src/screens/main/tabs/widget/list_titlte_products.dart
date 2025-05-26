import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String? date;
  final num amount;

  final Color color;

  const TransactionTile({
    super.key,
    required this.title,
    this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w(context)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color0080F2.withOpacity(.17),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(
              Icons.attach_money,
              color: color1C274C.withOpacity(.5),
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
                          title.capitalizeSentences,
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
                    style:
                        TextStyle(color: color51708E, fontSize: 12.w(context)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
