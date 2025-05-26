import 'package:banca_movil_comercial/src/bloc/languaje/languaje_bloc.dart';
import 'package:banca_movil_comercial/src/localization/app_localizations.dart';
import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguajeScreen extends StatelessWidget {
  const LanguajeScreen({super.key});
  static const String routeName = '/LanguajeScreen';

  // List<LanguajesModel> list = [
  //   LanguajesModel(
  //     title: "Español",
  //     description: "Predeterminado",
  //   ),
  //   LanguajesModel(
  //     title: "English",
  //     description: "inglés",
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: colorD5D5D5,
        title: Text(text.mainDraweLanguage),
        leading: IconButton(
          onPressed: context.pop,
          icon: Image(
            width: 30.w(context),
            image: AssetImage(AppImages.backBtn),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 26.w(context),
          vertical: 30.h(context),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color043371.withOpacity(.1),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _lang(
                    context: context,
                    title: "Español",
                    description: text.defaultKey,
                    selected: preferences.uLanguaje == "es",
                    onTap:
                        () => context.read<LanguajeBloc>().add(
                          LanguajeEvent("es"),
                        ),
                  ),
                  Divider(height: 0),
                  _lang(
                    context: context,
                    title: "English",
                    description: "Inglés",
                    selected: preferences.uLanguaje == "en",
                    onTap:
                        () => context.read<LanguajeBloc>().add(
                          LanguajeEvent("en"),
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 11.h(context)),
            Text(
              text.languageDescription,
              style: TextStyle(fontSize: 11.w(context), color: color506578),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lang({
    required BuildContext context,
    required String title,
    required String description,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w(context)),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.w(context),
                    color: color51708E,
                    fontWeight: FontWeightEnum.Medium.fWTheme,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.w(context), color: color506578),
                ),
              ],
            ),
            if (selected) Icon(Icons.check, color: color043371),
          ],
        ),
      ),
    );
  }
}

class LanguajesModel {
  String title;
  String description;

  LanguajesModel({required this.title, required this.description});
}
