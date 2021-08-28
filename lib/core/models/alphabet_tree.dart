import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'node.dart';

/// Alphabet Tree class, contains only a root field.
class AlphabetTree {
  /// Stores the root node.
  final Node root;

  const AlphabetTree(this.root);

  /// Takes another tree as an argument and compares its nodes.
  /// Comparison is performed using Depth First Search algorithm by [getElementsWithDFS]
  /// After storing the elements of both trees, unite their unique chars and creates a [SplayTreeSet],
  /// BTW, prints all unique chars.
  Set<String> compareTrees(AlphabetTree tree) {
    final firstTreeElements = SplayTreeSet<String>.from({tree.root.value});
    final secondTreeElements = SplayTreeSet<String>.from({root.value});
    getElementsWithDFS(tree.root, firstTreeElements);
    getElementsWithDFS(root, secondTreeElements);
    final intersection = firstTreeElements.intersection(secondTreeElements);
    final uniqueChars =
        firstTreeElements.union(secondTreeElements).difference(intersection);
    print(uniqueChars);
    return uniqueChars;
  }

  /// Stores all elements in a set using DFS.
  void getElementsWithDFS(Node otherRoot, SplayTreeSet<String> elements) {
    for (var i = 0; i < otherRoot.children.length; i++) {
      elements.add(otherRoot.children[i].value);
      getElementsWithDFS(otherRoot.children[i], elements);
    }
  }

  /// Adds a node to the specific place by using the given [parentKey].
  void addNode({required Key parentKey, required Node newNode, Node? node}) {
    node ??= root;
    for (var i = 0; i < node.children.length; i++) {
      if (node.children[i].uniqueKey == parentKey) {
        node.children[i].children.add(newNode);
      } else {
        addNode(parentKey: parentKey, newNode: newNode, node: node.children[i]);
      }
    }
  }

  /// Removes a node from the specific place by using the given [nodeKey].
  /// Replaces the removed node with its children.
  void removeNode({required Key nodeKey, Node? node}) {
    node ??= root;
    for (var i = 0; i < node.children.length; i++) {
      final elIndex = node.children[i].children
          .indexWhere((element) => element.uniqueKey == nodeKey);
      if (elIndex != -1) {
        final oldChildren = node.children[i].children[elIndex].children;
        node.children[i].children.removeAt(elIndex);
        node.children[i].children.addAll(oldChildren);
      } else {
        removeNode(nodeKey: nodeKey, node: node.children[i]);
      }
    }
  }

  /// Compares all nodes of the tree with another [tree] given as argument.
  /// Uses [compareDfs] method to traverse all nodes with DFS.
  bool compareAll(AlphabetTree tree) {
    if (tree.root.value != root.value) {
      return false;
    }
    return compareDfs(tree.root, root);
  }

  /// Compares all nodes recursively until finding a different node or reaching to the leaf nodes.
  bool compareDfs(Node node, Node otherNode) {
    for (var i = 0; i < node.children.length; i++) {
      if (node.children[i].value != otherNode.children[i].value) {
        return false;
      } else {
        compareDfs(node.children[i], otherNode.children[i]);
      }
    }
    return true;
  }
}
