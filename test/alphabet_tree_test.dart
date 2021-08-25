import 'package:bstevr_assessment/core/alphabet_tree.dart';
import 'package:bstevr_assessment/core/node.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  test("Sets should be exactly the same with the given ones.", () {
    const root1 = Node("Z", [
      Node("T", [
        Node("S", [Node("L", [])])
      ]),
      Node("I", [Node("Y", [])]),
      Node("D", [Node("P", [])])
    ]);
    const tree1 = AlphabetTree(root1);

    const root2 = Node("A", [
      Node("D", [Node("P", [])]),
      Node("D", [Node("P", [])]),
      Node("L", [])
    ]);
    const tree2 = AlphabetTree(root2);

    final set = tree1.compareTrees(tree2);

    expect(set, {"A", "I", "S", "T", "Y", "Z"});
  });
}
