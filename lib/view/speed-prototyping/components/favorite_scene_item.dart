import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

class FavoriteSceneItem extends StatelessWidget {
  final bool selected;
  final IconData icon;
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

  Widget getRow(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: selected ? Colors.orange : Colors.blueAccent),
        SizedBox(width: context.width * 2),
        Expanded(child: getText(context)),
      ],
    );
  }

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
