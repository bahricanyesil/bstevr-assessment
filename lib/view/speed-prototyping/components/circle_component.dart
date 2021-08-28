import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

class CircleComponent extends StatelessWidget {
  final IconData? extraIcon;
  final IconData? bottomIcon;
  final String bottomText;
  final Widget childWidget;
  const CircleComponent({
    Key? key,
    this.extraIcon,
    this.bottomIcon,
    required this.bottomText,
    required this.childWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 6, child: CircleWidget(mainWidget: childWidget)),
        Expanded(flex: 3, child: getBottomText(context)),
      ],
    );
  }

  Widget getBottomIcon(BuildContext context) {
    return Visibility(
      visible: bottomIcon != null,
      child: Padding(
        padding: context.horizontalLow,
        child: Icon(bottomIcon, color: Colors.white),
      ),
    );
  }

  Widget getBottomText(BuildContext context) {
    return Text(
      bottomText,
      style: context.headline6
          .copyWith(color: Colors.white, fontSize: context.fontSize * 2.4),
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
    );
  }
}
