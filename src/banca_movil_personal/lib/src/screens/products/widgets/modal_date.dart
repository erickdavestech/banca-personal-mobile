import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';

Future<DateTimeRange?> showCustomDateRangeDialog(BuildContext context) async {
  final startController = TextEditingController();
  final endController = TextEditingController();
  final dateFormat = DateFormat('dd/MM/yyyy');

  return showDialog<DateTimeRange>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final text = AppLocalizations.of(context)!;
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          text.dialogSelectRange,
          style:  TextStyle(
            fontSize: 18.h(context),
            color: Color(0xFF07355E),
            fontWeight: FontWeightEnum.SemiBold.fWTheme,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateField(
              label: text.dialogStartDate,
              controller: startController,
            ),
            const SizedBox(height: 12),
            _buildDateField(
              label: text.dialogEndDate,
              controller: endController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF07355E),
            ),
            child: Text(text.dialogAccept),
            onPressed: () {
              try {
                final start = dateFormat.parseStrict(startController.text);
                final end = dateFormat.parseStrict(endController.text);
                if (start.isAfter(end)) throw FormatException("Inicio > Fin");
                Navigator.pop(context, DateTimeRange(start: start, end: end));
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(text.errorInvalidDateFormat),
                  ),
                );
              }
            },
          ),
          TextButton(
            child: Text(text.dialogCancel),
            onPressed: () => Navigator.pop(context),
          ),
          
        ],
      );
    },
  );
}

Widget _buildDateField(
    {required String label, required TextEditingController controller}) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [
      LengthLimitingTextInputFormatter(10),
      FilteringTextInputFormatter.digitsOnly,
      _DateInputFormatter(),
    ],
    style: TextStyle(
      fontSize: 14,
      color: Color(0xFF506578),
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF506578),
      ),
      hintText: "dd/mm/aaaa",
      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF506578),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll("/", "");
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('/');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
