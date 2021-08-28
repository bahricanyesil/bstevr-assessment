import 'package:flutter/material.dart';
import '../../core_shelf.dart';

/// Customized App Bar widget implements [PreferredSizeWidget] and its required functions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title of the app will be displayed at top left.
  final String title;

  /// Toggle action that will be performed on switch operation on switch button.
  final Function()? toggleAction;

  /// Toggle value to understand corresponding switch value.
  final bool? toggleValue;

  /// Height of the app bar.
  final double size;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.toggleAction,
    this.toggleValue,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: getTitle(context),
      backgroundColor: context.canvasColor,
      brightness: Brightness.light,
      flexibleSpace: getMainContainer(context),
      automaticallyImplyLeading: false,
    );
  }

  /// Returns title's text widget with customized TextStyle.
  Widget getTitle(BuildContext context) => AutoSizeText(
        title,
        style: TextStyle(
          color: context.primaryColor,
          fontSize: context.fontSize * 4,
          fontWeight: FontWeight.w600,
        ),
      );

  /// Returns main container with a different value acc. to whether there is a switch button.
  Widget getMainContainer(BuildContext context) => Center(
        child: toggleValue == null
            ? Container()
            : CustomSwitchButton(
                toggleValue: toggleValue!,
                toggleAction: toggleAction!,
              ),
      );

  /// Overrides the [preferredSize] field with a given height value [size].
  @override
  Size get preferredSize => Size.fromHeight(size);
}
