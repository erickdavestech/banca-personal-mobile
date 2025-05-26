import 'package:banca_movil_comercial/src/screens/products/product_detail.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final String accountType;
  final ProductType type;
  final Color productNumberColor;
  final String imagePath;
  final String name;
  final String availableTitle;

  const ProductCard({
    required this.product,
    required this.accountType,
    required this.availableTitle,
    this.type = ProductType.account,
    this.productNumberColor = color0080F2,
    this.imagePath = AppImages.cuentaAhorro,
    this.name = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final available =
        (type == ProductType.loan) ? product.balance : product.available;

    return GestureDetector(
      onTap: () => _onCardTap(context),
      child: Container(
        width: 191.w(context),
        margin: EdgeInsets.only(
          left: 12.w(context),
          bottom: isTablet ? 40.h(context) : 30.h(context),
        ),
        decoration: _cardBoxDecoration(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.w(context),
            top: isTablet ? 20.w(context) : 12.w(context),
          ),
          child: Stack(
            children: [
              _buildTopSection(context),
              _buildBottomSection(context, available),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: color9F9F9F.withOpacity(.25),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  void _onCardTap(BuildContext context) async {
    if (context.mounted) {
      await context.pushNamed(ProductDetail.routeName, arguments: product);
    }
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(imagePath),
          height: 36.h(context),
          width: 37.w(context),
        ),
        SizedBox(width: 8.w(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$name:",
                style: TextStyle(
                  fontSize: 12.w(context),
                  fontWeight: FontWeightEnum.SemiBold.fWTheme,
                  color: color1C274C,
                ),
              ),

              if (!product.description.isNullOrEmpty &&
                  product.description != "N/A")
                Text(
                  "${product.description?.capitalizeSentences}",
                  style: TextStyle(fontSize: 10.w(context), color: color506578),
                ),
            ],
          ),
        ),
        SizedBox(width: 8.w(context)),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context, String? available) {
    final accountNumberText =
        type == ProductType.card || type == ProductType.creditCard
            ? product.accountNumber!.maskedCardShort
            : product.accountNumber!;

    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No. $accountType",
            style: TextStyle(fontSize: 13.w(context), color: color516578),
          ),
          Text(
            accountNumberText,
            style: TextStyle(
              fontSize: 13.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: productNumberColor,
            ),
          ),
          SizedBox(height: 9.h(context)),
          Text(
            availableTitle,
            style: TextStyle(fontSize: 12.w(context), color: color506578),
            textAlign: TextAlign.left,
          ),
          Text(
            "B/. ${num.parse(available ?? "0").priceFormat}",
            style: TextStyle(
              fontSize: 18.w(context),
              fontWeight: FontWeightEnum.Bold.fWTheme,
              color: color06243E,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 15.h(context)),
        ],
      ),
    );
  }
}
