import 'package:ca_mobile/src/screens/products/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:ca_mobile/src/screens/products/widgets/modal_transactions_filter.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ca_mobile/src/bloc/products_bloc/products_bloc.dart';

class TransactionListExtended extends StatefulWidget {
  static const routeName = '/transaction-list-extended';
  const TransactionListExtended({super.key});

  @override
  State<TransactionListExtended> createState() =>
      _TransactionListExtendedState();
}

class _TransactionListExtendedState extends State<TransactionListExtended> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image(
            width: 25.w(context),
            image: AssetImage(AppImages.backBtn),
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        title: Text(
          text.transactionsHistoryTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color07355E,
          ),
        ),
        actions: [
          InkWell(
            onTap: () => showTransactionFiltersModal(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                text.filtersButton,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF00519A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Divider(
            color: Color(0xFFEDEDED),
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x10005199),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      context
                          .read<ProductsBloc>()
                          .add(FilterTransactions(value));
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: text.search,
                      hintStyle: const TextStyle(
                        color: Color(0xFF506578),
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.search, color: Color(0xFF506578)),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: 23.75.w(context),
                  right: 23.75.w(context),
                  top: 10.h(context)),
              child: SingleChildScrollView(
                child: TransactionList(
                  onLoaded: (TransactionListModel model) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
