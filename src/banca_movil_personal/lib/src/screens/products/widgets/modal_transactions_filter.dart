import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ca_mobile/src/screens/products/widgets/modal_date.dart';
import 'package:ca_mobile/src/localization/app_localizations.dart';

class ThousandsFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return newValue.copyWith(text: '');
    String formatted =
        _formatter.format(int.parse(digitsOnly)).replaceAll('.', ',');
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

void showTransactionFiltersModal(BuildContext context) {
  DateTimeRange? selectedDateRange;
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String? selectedType;
  String? selectedPeriod;

  bool areFiltersSelected() {
    return selectedDateRange != null ||
        fromController.text.isNotEmpty ||
        toController.text.isNotEmpty ||
        selectedType != null;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.78,
          maxChildSize: 0.78,
          minChildSize: 0.78,
          expand: false,
          builder: (_, controller) {
            return StatefulBuilder(builder: (context, setState) {
              final text = AppLocalizations.of(context)!;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 40,
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              text.filtersButton,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF07355E),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close, size: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(text.filtersDate,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF06243E))),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final picked =
                              await showCustomDateRangeDialog(context);
                          if (picked != null) {
                            setState(() {
                              selectedDateRange = picked;
                              selectedPeriod = null;
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            selectedDateRange == null
                                ? text.filtersRangePlaceholder
                                : '${DateFormat('dd MMM yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(selectedDateRange!.end)}',
                            style: TextStyle(
                              color: Color(0xFF506578),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double fullWidth = constraints.maxWidth;
                          double buttonWidth = (fullWidth - 8) / 2;
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              SizedBox(
                                width: buttonWidth,
                                child: _buildDateButton(
                                  text.filtersLast3Months,
                                  selectedPeriod == "3",
                                  selectedDateRange == null
                                      ? () {
                                          setState(() {
                                            selectedPeriod = "3";
                                            selectedDateRange = DateTimeRange(
                                              start: DateTime.now()
                                                  .subtract(Duration(days: 90)),
                                              end: DateTime.now(),
                                            );
                                          });
                                        }
                                      : null,
                                ),
                              ),
                              SizedBox(
                                width: buttonWidth,
                                child: _buildDateButton(
                                  text.filtersLast6Months,
                                  selectedPeriod == "6",
                                  selectedDateRange == null
                                      ? () {
                                          setState(() {
                                            selectedPeriod = "6";
                                            selectedDateRange = DateTimeRange(
                                              start: DateTime.now().subtract(
                                                  Duration(days: 180)),
                                              end: DateTime.now(),
                                            );
                                          });
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 24),
                      Text(text.filtersAmount,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF06243E))),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            TextField(
                              controller: fromController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [ThousandsFormatter()],
                              style: TextStyle(color: Color(0xFF506578)),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        text.filtersFrom,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF506578)),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        text.filtersCurrency,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF506578)),
                                      ),
                                    ],
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 80),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: toController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [ThousandsFormatter()],
                              style: TextStyle(color: Color(0xFF506578)),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        text.filtersTo,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF506578)),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        text.filtersCurrency,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF506578)),
                                      ),
                                    ],
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 80),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(text.filtersTransactionType,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF06243E))),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        children: [
                          _buildChip(
                              text.filtersCredit, selectedType == "Crédito",
                              () {
                            setState(() => selectedType = "Crédito");
                          }),
                          _buildChip(
                              text.filtersDebit, selectedType == "Débito", () {
                            setState(() => selectedType = "Débito");
                          }),
                        ],
                      ),
                      SizedBox(height: 24),
                      Divider(thickness: 1, color: Color(0xFFEDEDED)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedDateRange = null;
                                  selectedPeriod = null;
                                  fromController.clear();
                                  toController.clear();
                                  selectedType = null;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Text(
                                  text.filtersClear,
                                  style: TextStyle(
                                    color: Color(0xFF00519A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 60),
                          Flexible(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return const Color(0xC4EDF3F8);
                                  }
                                  return const Color(0xFF00519A);
                                }),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return const Color(0xFF506578);
                                  }
                                  return Colors.white;
                                }),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              onPressed: areFiltersSelected()
                                  ? () {
                                      Navigator.pop(context);
                                    }
                                  : null,
                              child: FittedBox(child: Text(text.filtersApply)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
          },
        ),
      );
    },
  );
}

Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFE5F1FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Color(0xFF00519A) : Color(0xFF506578),
        ),
      ),
    ),
  );
}

Widget _buildDateButton(String label, bool isSelected, VoidCallback? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 23.5, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFDCEEFF) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? Color(0xFF00519A) : Color(0xFF506578),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
