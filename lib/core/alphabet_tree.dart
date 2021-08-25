import 'dart:collection';

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
}
