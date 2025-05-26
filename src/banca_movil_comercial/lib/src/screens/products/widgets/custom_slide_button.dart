import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class CustomSlideButton extends StatefulWidget {
  final VoidCallback onSlideComplete;
  final String text;

  const CustomSlideButton({
    super.key,
    required this.onSlideComplete,
    this.text = "Desliza para enviar",
  });

  @override
  State<CustomSlideButton> createState() => _CustomSlideButtonState();
}

class _CustomSlideButtonState extends State<CustomSlideButton>
    with SingleTickerProviderStateMixin {
  double _position = 0.0;
  bool _completed = false;
  late AnimationController _resetController;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxWidth) {
    if (_completed) return;
    setState(() {
      _pressed = true;
      _position += details.delta.dx;
      _position = _position.clamp(0.0, maxWidth - 64.w(context));
    });
  }

  void _onDragEnd(double maxWidth) {
    if (_completed) return;

    _pressed = false;

    if (_position > maxWidth * 0.75) {
      setState(() => _completed = true);
      widget.onSlideComplete();
    } else {
      _resetController.forward(from: 0).then((_) {
        _completed = false;
        setState(() => _position = 0.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = double.infinity;
    final height = 56.h(context);
    final borderRadius = BorderRadius.circular(12.w(context));

    if (_completed) {
      // ✅ Modo completado (barra azul completa)
      return Container(
        width: maxWidth,
        height: height,
        decoration: BoxDecoration(
          color: color0057A6,
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.w(context),
                fontWeight: FontWeightEnum.Medium.fWTheme,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.white, size: 24.w(context)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: height,
          child: Stack(
            children: [
              // Fondo blanco con borde azul
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: _pressed ? color0057A6 : Colors.white,
                  border: Border.all(color: color0057A6, width: 1),
                  borderRadius: borderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: _pressed ? Colors.white : color0057A6,
                    fontSize: 16.w(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Botón deslizante rectangular
              AnimatedBuilder(
                animation: _resetController,
                builder: (_, __) {
                  final animatedPos = _position * (1 - _resetController.value);
                  final double horizontalPadding = 6.w(context);
                  return Positioned(
                    left:
                        animatedPos +
                        horizontalPadding, // Aplica separación izquierda
                    top: 4.h(context),
                    bottom: 4.h(context),
                    child: GestureDetector(
                      onHorizontalDragUpdate:
                          (details) => _onDragUpdate(
                            details,
                            width - horizontalPadding * 2,
                          ), // Ajustar deslizamiento al nuevo ancho útil
                      onHorizontalDragEnd:
                          (_) => _onDragEnd(
                            width - horizontalPadding * 2,
                          ), // Igual
                      child: Container(
                        width: 56.w(context),
                        decoration: BoxDecoration(
                          color: _pressed ? Colors.white : color0057A6,
                          borderRadius: BorderRadius.circular(
                            8.w(context),
                          ), // más cuadrado
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward,
                          color: _pressed ? color0057A6 : Colors.white,
                          size: 24.w(context),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
