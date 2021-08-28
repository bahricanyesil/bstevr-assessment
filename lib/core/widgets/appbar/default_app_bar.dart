import 'package:flutter/material.dart';
import '../../core_shelf.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double size;
  final List<Widget> children;
  const DefaultAppBar({
    Key? key,
    required this.size,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      brightness: Brightness.light,
      flexibleSpace: getMainRow(context),
      automaticallyImplyLeading: false,
    );
  }

  Widget getMainRow(BuildContext context) {
    return Padding(
      padding: context.horizontalMedHigh,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
