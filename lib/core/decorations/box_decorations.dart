import 'package:flutter/material.dart';

import '../core_shelf.dart';

mixin BoxDecorations {
  static customSwitchDeco(BuildContext context, bool toggleValue) =>
      BoxDecoration(
        borderRadius: context.highCircular,
        color: toggleValue
            ? Colors.green[400]!.withOpacity(.2)
            : Colors.red[400]!.withOpacity(.2),
      );
}
