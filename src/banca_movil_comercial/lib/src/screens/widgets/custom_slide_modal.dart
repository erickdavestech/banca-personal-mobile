import 'package:banca_movil_comercial/src/extensions/sizer.dart';
import 'package:flutter/material.dart';

class CustomSlideModal extends StatefulWidget {
  final Widget child;
  final VoidCallback onClose;

  /// Altura inicial del modal al mostrarse por primera vez (en proporción de la pantalla).
  ///
  /// Valor entre 0.0 y 1.0 donde 1.0 representa el 100% de la altura de la pantalla.
  /// Por ejemplo, un valor de 0.48 significa que el modal ocupará inicialmente el 48%
  /// de la altura total de la pantalla.
  final double initialHeight;

  /// Altura mínima a la que el modal se puede contraer al hacer drag hacia abajo.
  ///
  /// También se expresa como proporción de la altura total de la pantalla.
  /// Evita que el modal se cierre por completo accidentalmente.
  final double minHeight;

  /// Altura del contenido del modal en píxeles.
  ///
  /// Este valor se utiliza como referencia para calcular el tamaño del contenido interno.
  /// Si el contenido supera esta altura, puede hacerse scroll.
  final double contentHeight;

  const CustomSlideModal({
    required this.child,
    required this.onClose,
    this.initialHeight = 0.48,
    this.minHeight = 0.3,
    this.contentHeight = 390,
    super.key,
  });

  @override
  State<CustomSlideModal> createState() => _CustomSlideModalState();
}

class _CustomSlideModalState extends State<CustomSlideModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  Future<void> _close() async {
    if (_isClosing) return;
    _isClosing = true;
    widget.onClose();
    await _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _close,
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _offsetAnimation,
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  /// Callback que maneja las notificaciones de cambio en el tamaño del modal (DraggableScrollableSheet).
                  ///
                  /// Este método se ejecuta cada vez que cambia la extensión (height) del modal. Si la altura actual
                  /// (`notification.extent`) es menor o igual a `minHeight + 0.02`, se interpreta como una intención
                  /// de cerrar el modal. En ese caso, se llama al método `_close()`, asegurándose de no hacerlo múltiples
                  /// veces gracias a la bandera `_isClosing`.
                  ///
                  /// Retorna `true` para indicar que la notificación ha sido manejada.
                  if (notification.extent <= widget.minHeight + 0.02) {
                    if (!_isClosing) {
                      _close();
                      _isClosing = true;
                    }
                  } else {
                    _isClosing = false;
                  }
                  return true;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, -15),
                      ),
                    ],
                  ),
                  child: DraggableScrollableSheet(
                    initialChildSize: widget.initialHeight.h(context),
                    minChildSize: widget.minHeight.h(context),
                    maxChildSize: 0.7.h(context),
                    expand: false,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            // Drag handle
                            Center(
                              child: Container(
                                width: 60.w(context),
                                height: 4.h(context),
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),

                            // Modal content
                            Container(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                                top: 5,
                              ),
                              height: widget.contentHeight.h(context),
                              child: widget.child,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
