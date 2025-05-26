import 'package:flutter/material.dart';

class SmoothClampingScrollPhysics extends ClampingScrollPhysics {
  const SmoothClampingScrollPhysics({super.parent});

  @override
  SmoothClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothClampingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Reduce un poco la fricción para que se sienta más suave
    return offset * 0.95;
  }
}
