import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';

class CoinDetector extends StatefulWidget {
  const CoinDetector({Key? key}) : super(key: key);

  @override
  _CoinDetectorState createState() => _CoinDetectorState();
}

class _CoinDetectorState extends State<CoinDetector>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _elementKey =
      GlobalKey<AnimatedListState>();
  List<String> _items = [];
  late Stream<String> _randomStream;
  bool _toggleValue = false;
  final StreamController _streamController = StreamController.broadcast();
  late StreamSubscription<String> _streamSubscription;
  late AnimationController _animationController;
  final AudioCache _audioCache = AudioCache();
  final Duration _kExpand = const Duration(milliseconds: 200);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  @override
  void initState() {
    super.initState();
    _randomStream = Stream.periodic(const Duration(seconds: 3), (int val) {
      final random = Random().nextInt(2);
      if (_elementKey.currentState != null) {
        _elementKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 500));
        _items = [random == 0 ? 'Real' : 'Fake', ..._items];
        if (random == 0) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
            final bytes =
                await (await _audioCache.loadAsFile('sound/coin_sound.mp3'))
                    .readAsBytes();
            await _audioCache.playBytes(bytes);
          });
        }
      }
      return random == 0 ? 'Real' : 'Fake';
    });
    _streamSubscription = _randomStream.listen(_streamController.add);
    _animationController = AnimationController(duration: _kExpand, vsync: this);

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      _audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: _streamController.stream,
      initialData: 'Waiting',
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // ignore: omit_local_variable_types
        List<Widget> children = [];
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
              children = [];
              break;
            case ConnectionState.done:
              children = doneWidgets(snapshot.data);
              break;
          }
        }
        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: snapshot.data ?? '',
              toggleValue: _toggleValue,
              toggleAction: toggleAction,
              size: context.height * 8,
            ),
            body: children.isEmpty
                ? AnimatedList(
                    key: _elementKey,
                    initialItemCount: _items.length,
                    itemBuilder: slideAnimation,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget slideAnimation(
      BuildContext context, int index, Animation<double> animation) {
    var item = _items[index];
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
        child: Card(
          color: item == 'Real' ? Colors.green : Colors.red,
          child: ExpansionTile(
            title: Container(
              alignment: Alignment.center,
              height: context.height * 10,
              child: Text(
                'Item $item',
                style: Theme.of(context).textTheme.headline4!,
                textAlign: TextAlign.center,
              ),
            ),
            children: [
              Text(
                'asdsad',
                textAlign: TextAlign.center,
              )
            ],
            trailing: RotationTransition(
              turns: _animationController.drive(_halfTween.chain(_easeInTween)),
              child: Padding(
                padding: context.topLowMed,
                child: const Icon(Icons.expand_more),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleAction() {
    if (_toggleValue && _streamSubscription.isPaused) {
      _streamSubscription.resume();
    } else if (!_toggleValue && !_streamSubscription.isPaused) {
      _streamSubscription.pause();
    } else {
      return;
    }
    setState(() {
      _toggleValue = !_toggleValue;
    });
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

  List<Widget> waitingWidgets() => <Widget>[
        const Spacer(),
        Padding(
          padding: context.verticalMedium,
          child: const CircularProgressIndicator(),
        ),
        const Text('Waiting for the data...'),
        const Spacer(),
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
