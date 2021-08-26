import 'dart:math';

import 'package:flutter/material.dart';

class CoinDetector extends StatefulWidget {
  const CoinDetector({Key? key}) : super(key: key);

  @override
  _CoinDetectorState createState() => _CoinDetectorState();
}

class _CoinDetectorState extends State<CoinDetector> {
  final GlobalKey<AnimatedListState> _elementKey =
      GlobalKey<AnimatedListState>();
  List<String> _items = [];
  final Stream<String> randomStream =
      Stream.periodic(const Duration(seconds: 3), (int val) {
    final random = Random().nextInt(2);
    return random == 0 ? 'Real' : 'Fake';
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: randomStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (_elementKey.currentState != null) {
          _elementKey.currentState!
              .insertItem(0, duration: const Duration(milliseconds: 500));
          _items = []
            ..add(snapshot.data ?? '')
            ..addAll(_items);
        }
        List<Widget> children;
        if (snapshot.hasError) {
          children = errorWidgets(snapshot);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              children = noneWidgets();
              break;
            case ConnectionState.waiting:
              children = waitingWidgets();
              break;
            case ConnectionState.active:
              children = activeWidgets(snapshot.data);
              break;
            case ConnectionState.done:
              children = doneWidgets(snapshot.data);
              break;
          }
        }
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: AnimatedList(
                  key: _elementKey,
                  initialItemCount: _items.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    return slideAnimation(context, index, animation);
                  },
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(color: Colors.greenAccent),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       FlatButton(
              //         onPressed: () {
              //           setState(() {
              //             _elementKey.currentState!.insertItem(0,
              //                 duration: const Duration(milliseconds: 500));
              //             _items = []
              //               ..add(counter++)
              //               ..addAll(_items);
              //           });
              //         },
              //         child: Text(
              //           "Add item to first",
              //           style: TextStyle(color: Colors.black, fontSize: 20),
              //         ),
              //       ),
              //       FlatButton(
              //         onPressed: () {
              //           if (_items.length <= 1) return;
              //           _elementKey.currentState!.removeItem(
              //               0,
              //               (_, animation) =>
              //                   slideAnimation(context, 0, animation),
              //               duration: const Duration(milliseconds: 500));
              //           setState(() {
              //             _items.removeAt(0);
              //           });
              //         },
              //         child: Text(
              //           "Remove first item",
              //           style: TextStyle(color: Colors.black, fontSize: 20),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget slideAnimation(
      BuildContext context, int index, Animation<double> animation) {
    String item = _items[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut)),
      child: FadeTransition(
        opacity: animation,
        child: SizedBox(
          height: 128.0,
          child: Card(
            color: item == 'Real' ? Colors.green : Colors.red,
            child: Center(
              child: Text('Item $item',
                  style: Theme.of(context).textTheme.headline4!),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> errorWidgets(AsyncSnapshot snapshot) => <Widget>[
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: ${snapshot.error}'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Stack trace: ${snapshot.stackTrace}'),
        ),
      ];

  List<Widget> noneWidgets() => const <Widget>[
        Icon(
          Icons.info,
          color: Colors.blue,
          size: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Select a lot'),
        )
      ];

  List<Widget> waitingWidgets() => const <Widget>[
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Awaiting bids...'),
        )
      ];

  List<Widget> activeWidgets(String? data) => <Widget>[
        const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(data ?? 'Real'),
        )
      ];

  List<Widget> doneWidgets(String? data) => <Widget>[
        const Icon(
          Icons.info,
          color: Colors.blue,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('\$$data (closed)'),
        )
      ];
}
