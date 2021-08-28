import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

/// Circle Component to display the top part of the screen.
class CircleComponent extends StatelessWidget {
  /// Extra icon that will be displayed at the right bottom of the [childWidget]
  final IconData? extraIcon;

  /// Bottom icon that will be displayed before the [bottomText]
  final IconData? bottomIcon;

  /// Bottom text that will be displayed under the [childWidget]
  final String bottomText;

  /// The main widget which fills the inside of the component
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

  /// Returns the bottom icon with a custom padding and visibility option.
  Widget getBottomIcon(BuildContext context) {
    return Visibility(
      visible: bottomIcon != null,
      child: Padding(
        padding: context.horizontalLow,
        child: Icon(bottomIcon, color: Colors.white),
      ),
    );
  }

  /// Returns the bottom text with a custom style.
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
