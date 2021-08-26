import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'node.dart';

class AlphabetTree {
  final Node root;

  const AlphabetTree(this.root);

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

  void getElementsWithDFS(Node otherRoot, SplayTreeSet<String> elements) {
    for (var i = 0; i < otherRoot.children.length; i++) {
      elements.add(otherRoot.children[i].value);
      getElementsWithDFS(otherRoot.children[i], elements);
    }
  }

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

  bool compareAll(AlphabetTree tree) {
    if (tree.root.value != root.value) {
      return false;
    }
    return compareDfs(tree.root, root);
  }

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
