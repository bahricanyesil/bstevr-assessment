import 'package:flutter/material.dart';

import '../../core_shelf.dart';

class CustomSwitchButton extends StatelessWidget {
  final bool toggleValue;
  final Function() toggleAction;
  const CustomSwitchButton(
      {Key? key, required this.toggleValue, required this.toggleAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: context.fast,
      width: context.width * 30,
      height: context.height * 6,
      decoration: BoxDecorations.customSwitchDeco(context, toggleValue),
      child: getButton(context),
    );
  }

  Widget getButton(BuildContext context) => InkWell(
        onTap: toggleAction,
        child: toggleValue
            ? getIconButton(
                context, 'Resume', Icons.play_circle_outline, Colors.green)
            : getIconButton(
                context, 'Pause', Icons.stop_circle_outlined, Colors.red),
      );

  Widget getIconButton(BuildContext context, String text, IconData icon,
          Color primaryColor) =>
      Row(
        mainAxisAlignment:
            text == 'Resume' ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          getButtonText(context, text == 'Pause', text),
          ElevatedButton(
              onPressed: toggleAction,
              child: Icon(icon, color: Colors.white),
              style:
                  ButtonStyles.customSwitchButtonStyle(context, primaryColor)),
          getButtonText(context, text == 'Resume', text),
        ],
      );

  Widget getButtonText(BuildContext context, bool visible, String text) =>
      Visibility(
          visible: visible,
          child: Padding(padding: context.horizontalLowMed, child: Text(text)));
}
