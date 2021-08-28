import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

/// Favorite Scene Item to display scenes.
class FavoriteSceneItem extends StatelessWidget {
  /// Indicates whether the item is selected.
  final bool selected;

  /// Icon that is displayed at the beginning of the item.
  final IconData icon;

  /// Text that explains the information about the item.
  final String text;
  const FavoriteSceneItem({
    Key? key,
    required this.selected,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorations.favoriteSceneDeco(context, selected),
      child: Padding(
        padding: context.lowEdgeInsets.copyWith(left: context.width * 2),
        child: getRow(context),
      ),
    );
  }

  /// The main widget inside of the container, contains other widgets as its children.
  Widget getRow(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: selected ? Colors.orange : Colors.blueAccent),
        SizedBox(width: context.width * 2),
        Expanded(child: getText(context)),
      ],
    );
  }

  /// Returns the explanation text with a custom style and overflow option.
  Widget getText(BuildContext context) {
    return Text(
      text,
      style: context.headline4.copyWith(
        fontWeight: FontWeight.w800,
        color: selected ? Colors.black87 : Colors.blueAccent,
      ),
      overflow: TextOverflow.clip,
    );
  }
}
