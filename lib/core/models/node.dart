import 'package:flutter/widgets.dart';

/// Simple [Node] class contains
/// [value] to store alphabetic character
/// [children] to store children nodes of this node.
/// [uniqueKey] to easily reach when needed by providing a unique field.
class Node {
  final String value;
  final List<Node> children;
  final Key uniqueKey = UniqueKey();
  Node(this.value, this.children);
}
