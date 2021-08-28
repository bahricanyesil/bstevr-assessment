import 'package:flutter/material.dart';

import '../../core_shelf.dart';

/// Custom Switch Button to be able to switch between two option.
class CustomSwitchButton extends StatelessWidget {
  /// Toggle value that will be displayed
  final bool toggleValue;

  /// Toggle action that will be performed when clicked.
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

  /// The button that will be shown in the container.
  Widget getButton(BuildContext context) => InkWell(
        onTap: toggleAction,
        child: toggleValue
            ? getIconButton(
                context, 'Resume', Icons.play_circle_outline, Colors.green)
            : getIconButton(
                context, 'Pause', Icons.stop_circle_outlined, Colors.red),
      );

  /// Returns the icon button acc. to [text] value as 'Resume' or 'Pause'.
  Widget getIconButton(BuildContext context, String text, IconData icon,
          Color primaryColor) =>
      Row(
        mainAxisAlignment:
            text == 'Resume' ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          getButtonText(context, text == 'Pause', text),
          getElevatedButton(context, icon, primaryColor),
          getButtonText(context, text == 'Resume', text),
        ],
      );

  Widget getElevatedButton(
      BuildContext context, IconData icon, Color primaryColor) {
    return ElevatedButton(
        onPressed: toggleAction,
        child: Icon(icon, color: Colors.white),
        style: ButtonStyles.customSwitchButtonStyle(context, primaryColor));
  }

  Widget getButtonText(BuildContext context, bool visible, String text) =>
      Visibility(
          visible: visible,
          child: Padding(
              padding: context.horizontalLowMed, child: AutoSizeText(text)));
}
