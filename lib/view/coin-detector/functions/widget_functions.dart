import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

mixin CoinDetectorWidgetFunctions {
  static List<Widget> childrenBySnapshot(
      AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return _errorWidgets(snapshot, context);
    } else {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return _noneWidgets(context);
        case ConnectionState.waiting:
          return [];
        case ConnectionState.active:
          return [];
        case ConnectionState.done:
          return _doneWidgets(snapshot.data, context);
      }
    }
  }

  static List<Widget> _errorWidgets(
          AsyncSnapshot snapshot, BuildContext context) =>
      <Widget>[
        const Spacer(flex: 30),
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: context.width * 20,
        ),
        const Spacer(flex: 2),
        Expanded(flex: 3, child: AutoSizeText('Error: ${snapshot.error}')),
        const Spacer(),
        Expanded(
            flex: 3,
            child: AutoSizeText('Stack trace: ${snapshot.stackTrace}')),
        const Spacer(flex: 30),
      ];

  static List<Widget> _noneWidgets(BuildContext context) => <Widget>[
        const Spacer(flex: 30),
        Icon(
          Icons.info,
          color: Colors.blue,
          size: context.width * 25,
        ),
        const Spacer(flex: 2),
        const AutoSizeText('Select a lot'),
        const Spacer(flex: 30),
      ];

  static List<Widget> _doneWidgets(String? data, BuildContext context) =>
      <Widget>[
        const Spacer(flex: 30),
        Icon(
          Icons.done,
          color: Colors.green,
          size: context.width * 25,
        ),
        const Spacer(),
        Text('\$$data (closed)'),
        const Spacer(flex: 30),
      ];
}
