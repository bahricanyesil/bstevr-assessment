import 'package:bstevr_assessment/core/alphabet_tree.dart';
import 'package:bstevr_assessment/core/node.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group('Alphabet Tree Tests', () {
    test("Sets should be exactly the same with the given ones.", () {
      final root1 = Node("Z", [
        Node("T", [
          Node("S", [Node("L", [])])
        ]),
        Node("I", [Node("Y", [])]),
        Node("D", [Node("P", [])])
      ]);
      final tree1 = AlphabetTree(root1);

      final root2 = Node("A", [
        Node("D", [Node("P", [])]),
        Node("D", [Node("P", [])]),
        Node("L", [])
      ]);
      final tree2 = AlphabetTree(root2);

      final root3 = Node("Z", [
        Node("D", [Node("L", [])]),
        Node("S", [Node("P", [])]),
        Node("X", [])
      ]);
      final tree3 = AlphabetTree(root3);

      final root4 = Node("K", [
        Node("T", [
          Node("Q", [Node("M", [])])
        ]),
        Node("S", [Node("N", [])]),
        Node("Z", [Node("B", [])])
      ]);
      final tree4 = AlphabetTree(root4);

      final set = tree1.compareTrees(tree2);
      final set2 = tree1.compareTrees(tree3);
      final set3 = tree1.compareTrees(tree4);

      expect(set, {"A", "I", "S", "T", "Y", "Z"});
      expect(set2, {"I", "T", "Y", "X"});
      expect(set3, {"B", "D", "I", "K", "L", "M", "N", "P", "Q", "Y"});
    });

    test("Node creation test", () {
      final parentNode = Node("S", [Node("L", [])]);
      final root1 = Node("Z", [
        Node("T", [parentNode]),
        Node("I", [Node("Y", [])]),
        Node("D", [Node("P", [])])
      ]);
      final tree = AlphabetTree(root1);
      final newNode = Node("G", []);
      tree.addNode(parentKey: parentNode.uniqueKey, newNode: newNode);

      final finalRoot = Node("Z", [
        Node("T", [
          Node("S", [Node("L", []), newNode])
        ]),
        Node("I", [Node("Y", [])]),
        Node("D", [Node("P", [])])
      ]);
      expect(tree.compareAll(AlphabetTree(finalRoot)), true);
    });

    test("Node deletion test", () {
      final deleteNode = Node("S", [Node("L", [])]);
      final root1 = Node("Z", [
        Node("T", [deleteNode]),
        Node("I", [Node("Y", [])]),
        Node("D", [Node("P", [])])
      ]);
      final tree = AlphabetTree(root1);
      tree.removeNode(nodeKey: deleteNode.uniqueKey);

      final finalRoot = Node("Z", [
        Node("T", [Node("L", [])]),
        Node("I", [Node("Y", [])]),
        Node("D", [Node("P", [])])
      ]);
      expect(tree.compareAll(AlphabetTree(finalRoot)), true);
    });
  });
}
