import 'package:banca_movil_comercial/src/bloc/products_bloc/products_bloc.dart';
import 'package:banca_movil_comercial/src/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsTransferScreen extends StatelessWidget {
  static const String routeName = '/products-transfer';
  const ProductsTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final isOriginProduct = ModalRoute.of(context)!.settings.arguments as bool;
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
          isOriginProduct
              ? text.productTransferOrigin
              : text.productTransferDestination,
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
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  return ListView(
                    children:
                        state.products.account.products
                            .map(
                              (cuenta) => _productCard(
                                context,
                                cuenta,
                                isOriginProduct,
                              ),
                            )
                            .toList(),
                  );
                }
                return Center(child: CircularProgressIndicator.adaptive());
              },
            ),
          ),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              Product? selectedProduct;

              selectedProduct = state.selectedProduct;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom,
                  left: 21.w(context),
                  right: 21.w(context),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: colorD5D5D5,
                  ),
                  onPressed:
                      selectedProduct == null
                          ? null
                          : () {
                            if (isOriginProduct) {
                              context.read<TransactionBloc>().add(
                                GetProductFromTransferEvent(selectedProduct!),
                              );
                            } else {
                              context.read<TransactionBloc>().add(
                                GetProductToTransferEvent(selectedProduct!),
                              );
                            }
                            context.pop();
                          },
                  child: Text(
                    selectedProduct == null
                        ? text.productTransferButton
                        : text.select,
                    style:
                        selectedProduct == null
                            ? TextStyle(
                              fontSize: 14.w(context),
                              color: color506578,
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

  Widget _productCard(
    BuildContext context,
    Product cuenta,
    bool isOriginProduct,
  ) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        Product? selected;
        Product? productDisabled;

        if (isOriginProduct) {
          productDisabled = state.destinationProduct;
        } else {
          productDisabled = state.sourceProduct;
        }
        selected = state.selectedProduct;

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 21.w(context),
              ).copyWith(top: 12.h(context)),
              child: GestureDetector(
                onTap: () {
                  if (productDisabled?.id == cuenta.id) return;
                  context.read<TransactionBloc>().add(
                    ProductSelectedEvent(cuenta),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color:
                        productDisabled?.id == cuenta.id ? colorF9F9F9 : null,
                    border: Border.all(
                      color:
                          cuenta.id == selected?.id ? color043371 : colorDCE2E8,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage(cuenta.iconPath),
                        width: 37.w(context),
                        height: 36.h(context),
                        color:
                            productDisabled?.id == cuenta.id
                                ? color506578
                                : null,
                      ),
                      SizedBox(width: 13.5.w(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cuenta.typeDescription,
                              style: TextStyle(
                                fontWeight: FontWeightEnum.SemiBold.fWTheme,
                                fontSize: 12.0,
                                color: color06243E,
                              ),
                            ),
                            Text(
                              "${cuenta.description}",
                              style: TextStyle(
                                fontSize: 12.h(context),
                                color: color506578,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "B./ ${num.parse(cuenta.available ?? '0').priceFormat}",
                        style: TextStyle(
                          color: color06243E,
                          fontWeight: FontWeightEnum.SemiBold.fWTheme,
                          fontSize: 12.w(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (cuenta.id == selected?.id)
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
