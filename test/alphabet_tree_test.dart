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

    const root3 = Node("Z", [
      Node("D", [Node("L", [])]),
      Node("S", [Node("P", [])]),
      Node("X", [])
    ]);
    const tree3 = AlphabetTree(root3);

    const root4 = Node("K", [
      Node("T", [
        Node("Q", [Node("M", [])])
      ]),
      Node("S", [Node("N", [])]),
      Node("Z", [Node("B", [])])
    ]);
    const tree4 = AlphabetTree(root4);

    final set = tree1.compareTrees(tree2);
    final set2 = tree1.compareTrees(tree3);
    final set3 = tree1.compareTrees(tree4);

    expect(set, {"A", "I", "S", "T", "Y", "Z"});
    expect(set2, {"I", "T", "Y", "X"});
    expect(set3, {"B", "D", "I", "K", "L", "M", "N", "P", "Q", "Y"});
  });
}
