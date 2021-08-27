import 'package:flutter/material.dart';

mixin SlideTransitionAnimations {
  static Animation<Offset> coinDetectorAnimation(Animation<double> animation) =>
      Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
        ),
      );
}
