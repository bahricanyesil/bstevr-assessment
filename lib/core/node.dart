import 'package:flutter/cupertino.dart';

class Node {
  final String value;
  final List<Node> children;
  final Key key = UniqueKey();
  Node(this.value, this.children);
}
