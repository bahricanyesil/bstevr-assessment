import 'package:flutter/material.dart';

import '../../core_shelf.dart';

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
