import 'package:flutter/material.dart';

import '../core_shelf.dart';

mixin BoxDecorations {
  static BoxDecoration customSwitchDeco(
          BuildContext context, bool toggleValue) =>
      BoxDecoration(
        borderRadius: context.highCircular,
        color: toggleValue
            ? Colors.green[400]!.withOpacity(.2)
            : Colors.red[400]!.withOpacity(.2),
      );

  static BoxDecoration favoriteSceneDeco(BuildContext context, bool selected) =>
      BoxDecoration(
        borderRadius: context.mediumCircular,
        color: selected ? Colors.white : Colors.white.withOpacity(.3),
      );

  static BoxDecoration circleDeco(BuildContext context,
      [Color color = Colors.white]) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: Colors.white, width: context.width),
    );
  }
}
