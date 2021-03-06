import 'package:flutter/material.dart';

import '../core_shelf.dart';

/// Mixin for button styles, contains specialized styles for each button.
mixin ButtonStyles {
  static customSwitchButtonStyle(BuildContext context, Color primaryColor) =>
      ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: context.highCircular),
        primary: primaryColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: Size(context.height * 6, context.height * 6),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        animationDuration: context.tooSlow,
      );
}
