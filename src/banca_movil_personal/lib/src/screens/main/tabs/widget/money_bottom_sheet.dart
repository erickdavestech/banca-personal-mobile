import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';
import 'package:ca_mobile/src/screens/products/interbank_transfer.dart';
import 'package:ca_mobile/src/screens/products/transferencia_page.dart';

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final GlobalKey fabKey;

  const CustomBottomSheet({super.key, required this.fabKey});

  double _getFabPosition(BuildContext context) {
    final RenderBox? renderBox =
        fabKey.currentContext?.findRenderObject() as RenderBox?;
    double fabBottomOffset = MediaQuery.paddingOf(context).bottom;
    if (renderBox != null) {
      Offset position = renderBox.localToGlobal(Offset.zero);
      double screenHeight = MediaQuery.of(context).size.height;
      double fabY = position.dy; // Altura desde la parte superior
      double fabHeight = renderBox.size.height;
      fabBottomOffset =
          screenHeight - (fabY + fabHeight); // Distancia desde abajo
    }
    return fabBottomOffset;
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipPath(
            clipper: BottomSheetClipper(), // Aquí aplicamos la curva
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 20.h(context),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context: context,
                    title: text.moneyBottomTransferTitle,
                    subtitle: text.moneyBottomTransferSubTitle,
                    items: [
                      _buildIconButton(
                        context,
                        AppImages.moneyCoinTransfer,
                        text.moneyBottomTransferAccount,
                        onPressed: () {
                          context.pushNamed(
                              TransferBetweenAccountsScreen.routeName);
                        },
                      ),
                      _buildIconButton(
                        context,
                        AppImages.usersGroupRounded,
                        text.moneyBottomTransferThirdPartyAccount,
                      ),
                      _buildIconButton(context, AppImages.bank,
                          text.moneyBottomTransferBanks, onPressed: () {
                        context.pushNamed(
                          InterbankScreen.routeName,
                        );
                      }),
                      _buildIconButton(
                        context,
                        AppImages.transactionGlobe,
                        text.moneyBottomTransferInternational,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.calendar,
                        text.moneyBottomTransferScheduled,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.yappyFondo,
                        text.moneyBottomTransferYappy,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.kuaraFondo,
                        text.moneyBottomTransferKuara,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
                    child: Divider(
                      color: colorD5D5D5,
                    ),
                  ),
                  _buildSection(
                    context: context,
                    title: text.moneyBottomPayTitle,
                    subtitle: text.moneyBottomPaySubTitle,
                    items: [
                      _buildIconButton(
                        context,
                        AppImages.card2,
                        text.moneyBottomPayCard,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.handMoney,
                        text.moneyBottomPayLoan,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.bill,
                        text.moneyBottomPayService,
                      ),
                      _buildIconButton(
                        context,
                        AppImages.chatRoundMoney,
                        text.moneyBottomPayrecharge,
                      ),
                    ],
                  ),
                  SizedBox(height: 50), // Espacio para el botón de cerrar
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: _getFabPosition(context),
            ),
            child: _buildCloseButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required List<Widget> items,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.w(context),
              fontWeight: FontWeightEnum.SemiBold.fWTheme,
              color: color06243E,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.w(context),
              color: color506578,
            ),
          ),
        ),
        SizedBox(height: 8.h(context)),
        GridView.count(
          padding: EdgeInsets.zero,
          // crossAxisSpacing: 20,
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: .9,
          mainAxisSpacing: 30,
          children: items,
        ),
        SizedBox(height: 10.h(context)),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    String iconPath,
    String text, {
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        context.pop();
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorD5D5D5,
              ),
            ),
            child: Image(
              image: AssetImage(iconPath),
              width: 25.w(context),
              height: 25.w(context),
            ),
          ),
          SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.w(context),
              color: color212121,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pop(context),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
      child: Icon(Icons.close, color: Colors.blue),
    );
  }
}

class BottomSheetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 20;
    double curveWidth = 20;
    double centerX = size.width / 2;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height - curveHeight,
      ),
      Radius.circular(20),
    ));

    // Dibujamos la curvita (flecha)
    path.moveTo(
      centerX - curveWidth / 2,
      size.height - curveHeight,
    );
    path.quadraticBezierTo(
      centerX,
      size.height,
      centerX + curveWidth / 2,
      size.height - curveHeight,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
