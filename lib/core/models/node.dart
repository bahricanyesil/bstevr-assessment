import 'package:flutter/widgets.dart';

class Node {
  final String value;
  final List<Node> children;
  final Key uniqueKey = UniqueKey();
  Node(this.value, this.children);
}
