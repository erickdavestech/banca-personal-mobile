import 'package:banca_movil_comercial/src/extensions/context_extensions.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TransactionType { debit, credit }

class SingleTransactionItem extends StatelessWidget {
  final TransactionType transactionType;
  final TransactionDetail transactionDetail;
  final bool isFromCardTransaction;
  final String? cardNumber;

  const SingleTransactionItem({
    super.key,
    required this.transactionType,
    required this.transactionDetail,
    this.isFromCardTransaction = true,
    this.cardNumber,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDebit = transactionType == TransactionType.debit;
    final String cardTerminal = cardNumber?.maskedCardShort ?? '';
    final Color amountColor = isDebit ? colorCE1228 : color07355E;
    final String iconPath =
        isDebit ? AppImages.transactionDebit : AppImages.transactionCredit;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w(context)),
      height: 85.h(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color005199.withOpacity(.09), width: 1),
        ),
      ),
      child: Row(
        children: [
          // ICON
          Image.asset(iconPath, height: 45.h(context), width: 45.w(context)),
          SizedBox(width: 20.w(context)),

          // TITLE, DATE COLUMN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TITLE
                Container(
                  margin: EdgeInsets.only(right: 10.w(context)),
                  child: Text(
                    transactionDetail.narrative ?? 'N/A',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: color07355E,
                      fontWeight: FontWeightEnum.SemiBold.fWTheme,
                      fontSize: 14.w(context),
                    ),
                  ),
                ),

                // DATE
                if (transactionDetail.transactionDate != null)
                  Text(
                    DateFormat.yMMMd()
                        .format(
                          transactionDetail.transactionDate ?? DateTime.now(),
                        )
                        .capitalize,
                    style: TextStyle(color: color51708E, fontSize: 12.5),
                  ),
              ],
            ),
          ),
          SizedBox(width: 20.w(context)),

          // AMOUNT, CARD TERMINAL COLUMN
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // AMOUNT
              Text(
                'B/. ${transactionDetail.amount?.priceFormat}',
                style: TextStyle(
                  color: amountColor,
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  fontSize: 14,
                ),
              ),

              // CARD TERMINAL
              if (isFromCardTransaction && !cardTerminal.isNullOrEmpty)
                Text(
                  '${context.lang.card}  $cardTerminal',
                  style: TextStyle(color: color51708E, fontSize: 12.5),
                ),
            ],
          ),
          SizedBox(width: 15.w(context)),
          // GO TO DETAIL ICON
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: color1C274C,
              size: 12.w(context),
            ),
            // TODO: Implement this Got to Transaction Details
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
