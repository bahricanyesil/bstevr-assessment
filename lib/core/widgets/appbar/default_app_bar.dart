import 'package:flutter/material.dart';
import '../../core_shelf.dart';

/// Default App Bar implements [PreferredSizeWidget] with its required functions.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Height of the app bar.
  final double size;

  /// Widgets will be placed into the app bar.
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

  /// Creates the main row of the app bar with given [children] widgets and suitable padding value.
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

  /// Overrides the [preferredSize] field with a given height value [size].
  @override
  Size get preferredSize => Size.fromHeight(size);
}
