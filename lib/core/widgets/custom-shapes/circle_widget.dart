import 'package:flutter/material.dart';

import '../../core_shelf.dart';

/// Circle Widget which will be used as a wrapper of its [mainWidget]
/// Gives a circular shape to the its child.
class CircleWidget extends StatelessWidget {
  final Widget mainWidget;
  const CircleWidget({Key? key, required this.mainWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecorations.circleDeco(context),
      width: context.width * 16,
      child: mainWidget,
    );
  }
}
