import 'package:flutter/material.dart';
import '../../core_shelf.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? toggleAction;
  final bool? toggleValue;
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

  Widget getTitle(BuildContext context) => AutoSizeText(
        title,
        style: TextStyle(
          color: context.primaryColor,
          fontSize: context.fontSize * 4,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget getMainContainer(BuildContext context) => Center(
        child: toggleValue == null
            ? Container()
            : CustomSwitchButton(
                toggleValue: toggleValue!,
                toggleAction: toggleAction!,
              ),
      );

  @override
  Size get preferredSize => Size.fromHeight(size);
}
