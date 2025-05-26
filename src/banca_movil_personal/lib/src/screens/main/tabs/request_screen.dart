import "package:banca_movil_libs/banca_movil_libs.dart";
import "package:ca_mobile/src/localization/app_localizations.dart";

import "package:flutter/material.dart";
import "package:intl/intl.dart";

class Solicitud {
  final String type;
  final String title;
  final String noRequest;
  final String date;
  final String status;
  final String iconPath;
  final Color colorStatus;
  final Color colorRequest;
  final Color colorStatusTitle;

  Solicitud({
    required this.type,
    required this.title,
    required this.date,
    required this.status,
    required this.noRequest,
    required this.iconPath,
    required this.colorStatus,
    required this.colorRequest,
    required this.colorStatusTitle,
  });
}

class RequestScreen extends StatefulWidget {
  static const routeName = '/RequestScreen';
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool _isProductSelected = true;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final List<Solicitud> solicitudes = [
      Solicitud(
          type: text.tabButtonRequestProduct,
          title: text.checkingAccount,
          date: DateFormat('d MMM yyyy').format(DateTime.now()),
          status: text.review,
          colorRequest: color0080F2,
          noRequest: '0908000',
          iconPath: AppImages.cuentaAhorro,
          colorStatus: colorF17A4C.withOpacity(0.1),
          colorStatusTitle: colorF17A4C),
      Solicitud(
          type: text.tabButtonRequestProduct,
          title: text.digitalAccount,
          date: DateFormat('d MMM yyyy').format(DateTime.now()),
          status: text.aproved,
          colorRequest: color0080F2,
          noRequest: '0908001',
          iconPath: AppImages.cuentaAhorro,
          colorStatus: colorD7F8E1.withOpacity(.10),
          colorStatusTitle: color45A42E),
      // Solicitud(
      //     type: text.tabButtonRequestService,
      //     title: text.servicePayment,
      //     date: DateFormat('d MMM yyyy').format(DateTime.now()),
      //     status: text.pending,
      //     colorRequest: Colors.orange,
      //     noRequest: '0908002',
      //     iconPath: AppImages.documentsIconPath,
      //     colorStatus: colorF17A4C.withOpacity(0.1),
      //     colorStatusTitle: colorF17A4C),
    ];

    final filteredSolicitudes = solicitudes
        .where((item) => _isProductSelected
            ? item.type == text.tabButtonRequestProduct
            : item.type == text.tabButtonRequestService)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.requestTitle,
          style: TextStyle(
            fontSize: 19.w(context),
          ),
        ),
        toolbarHeight: 80.h(context),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: colorD5D5D5,
            thickness: 1,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 19.h(context)),
        child: Column(
          children: [
            Container(
              width: 382.w(context),
              height: 59.h(context),
              decoration: BoxDecoration(
                color: color506578.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(26)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isProductSelected = true;
                      });
                    },
                    child: _tabButton(
                        text.tabButtonRequestProduct, _isProductSelected),
                  ),
                  SizedBox(width: 8.w(context)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isProductSelected = false;
                      });
                    },
                    child: _tabButton(
                        text.tabButtonRequestService, !_isProductSelected),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredSolicitudes.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 128.w(context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(AppImages.noRequest),
                          ),
                          SizedBox(height: 34.h(context)),
                          Text(
                            text.noRequests,
                            style: TextStyle(
                              fontSize: 16.w(context),
                              color: color07355E.withOpacity(.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ))
                  : ListView(
                      children: filteredSolicitudes
                          .map(
                            (item) => _solicitudCard(item, text),
                          )
                          .toList(),
                    ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: color005199,
                ),
                child: Text(text.buttonRequest,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeightEnum.Medium.fWTheme)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, bool isSelected) {
    return Container(
      width: 178.w(context),
      height: 40.h(context),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
        color: isSelected ? color005199 : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _solicitudCard(Solicitud item, AppLocalizations text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color9F9F9F.withOpacity(.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: item.colorRequest,
            width: 6,
          ),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: AssetImage(item.iconPath),
                  width: 37.w(context),
                  height: 36.h(context),
                ),
                SizedBox(width: 8.w(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text.requestCardItemTitle,
                        style: TextStyle(
                          fontSize: 12.w(context),
                          color: color07355E.withOpacity(.7),
                        ),
                      ),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14.w(context),
                          color: color07355E,
                          fontWeight: FontWeightEnum.Medium.fWTheme,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(
              color: color07355E.withOpacity(.1),
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text.requestCardItemNumberRequest,
                        style: TextStyle(color: color506578)),
                    Text(item.noRequest,
                        style: TextStyle(
                            color: color06243E,
                            fontWeight: FontWeightEnum.Medium.fWTheme)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text.requestCardItemDay,
                      style: TextStyle(
                        color: color506578,
                      ),
                    ),
                    Text(
                      item.date,
                      style: TextStyle(
                        color: color06243E,
                        fontWeight: FontWeightEnum.Medium.fWTheme,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: item.colorStatus.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      color: item.colorStatusTitle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
