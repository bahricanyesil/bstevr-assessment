import 'package:flutter/material.dart';
import '../core_shelf.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(int index) toggleAction;
  final List<bool> isSelected;
  final double size;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.toggleAction,
    required this.isSelected,
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

  Widget getTitle(BuildContext context) => Text(
        title,
        style: TextStyle(
          color: context.primaryColor,
          fontSize: context.fontSize * 3,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget getMainContainer(BuildContext context) => Center(
        child: toggleButton(),
      );

  Widget toggleButton() => ToggleButtons(
        children: <Widget>[
          Icon(Icons.play_arrow_outlined, color: Colors.green[400]),
          Icon(Icons.pause_circle_outline_outlined, color: Colors.red[400]),
        ],
        onPressed: toggleAction,
        isSelected: isSelected,
      );

  @override
  Size get preferredSize => Size.fromHeight(size);
}
