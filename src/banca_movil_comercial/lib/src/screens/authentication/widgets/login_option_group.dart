import 'package:banca_movil_comercial/src/screens/widgets/custom_slide_modal.dart';
import 'package:flutter/material.dart';
import 'package:banca_movil_comercial/src/extensions/sizer.dart';
import 'package:banca_movil_libs/themes/colors.dart';

class LoginOptionItem {
  final String title;
  final String icon;
  final Widget child;

  LoginOptionItem({
    required this.title,
    required this.icon,
    required this.child,
  });
}

class LoginOptionsGroup extends StatefulWidget {
  final List<LoginOptionItem> items;
  final bool isTablet;

  const LoginOptionsGroup({
    super.key,
    required this.items,
    this.isTablet = false,
  });

  @override
  State<LoginOptionsGroup> createState() => _LoginOptionsGroupState();
}

class _LoginOptionsGroupState extends State<LoginOptionsGroup> {
  int? _selectedIndex;
  OverlayEntry? _overlayEntry;

  void _toggleModal(int index) {
    final isSame = _selectedIndex == index;

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    if (!isSame) {
      _selectedIndex = index;
      _showModal(widget.items[index].child, index);
    } else {
      _selectedIndex = null;
    }

    setState(() {});
  }

  void _showModal(Widget content, int index) {
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned.fill(
            // Obviando los primeros 80 px desde abajo para respetar
            // la visualización del bottomNavigationBar
            bottom: 80.h(context),
            child: CustomSlideModal(
              onClose: () {
                setState(() {
                  _selectedIndex = null;
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                });
              },
              child: content,
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.items.length * 2 - 1, (i) {
        // Alterna entre item y divisor
        if (i.isOdd) {
          return VerticalDivider(color: color07355E.withOpacity(.12));
        }

        final itemIndex = i ~/ 2;
        final item = widget.items[itemIndex];
        final isSelected = _selectedIndex == itemIndex;
        final contentColor = isSelected ? color0080F2 : color07355E;

        return Expanded(
          child: InkWell(
            onTap: () => _toggleModal(itemIndex),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  item.icon,
                  color: contentColor,
                  height: widget.isTablet ? 25.w(context) : 20.w(context),
                  width: widget.isTablet ? 25.w(context) : 20.w(context),
                ),
                SizedBox(height: 4.w(context)),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: widget.isTablet ? 18.w(context) : 14.w(context),
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
