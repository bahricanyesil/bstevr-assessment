import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';
import 'components/components_shelf.dart';
import 'functions/functions_shelf.dart';

class CoinDetector extends StatefulWidget {
  const CoinDetector({Key? key}) : super(key: key);

  @override
  _CoinDetectorState createState() => _CoinDetectorState();
}

class _CoinDetectorState extends State<CoinDetector> {
  final GlobalKey<AnimatedListState> _elementKey =
      GlobalKey<AnimatedListState>();
  final List<dynamic> _items = [];
  late Stream<String> _randomStream;
  final StreamController _streamController = StreamController.broadcast();
  late StreamSubscription<String> _streamSubscription;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final AudioCache _audioCache;
  final List<dynamic> _expandedKeys = [];

  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    _randomStream =
        HelperFunctions.getRandomStream(_elementKey, _audioCache, _items);
    _streamSubscription = _randomStream.listen(_streamController.add);
    if (kIsWeb) return;
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
        List<Widget> children =
            CoinDetectorWidgetFunctions.childrenBySnapshot(snapshot, context);
        return getSafeArea(snapshot, children);
      },
    );
  }

  Widget getSafeArea(AsyncSnapshot snapshot, List<Widget> children) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(snapshot),
        body:
            children.isEmpty ? getAnimatedList() : getCenteredColumn(children),
      ),
    );
  }

  Widget getCenteredColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  CustomAppBar getAppBar(AsyncSnapshot snapshot) {
    return CustomAppBar(
      title: snapshot.data ?? '',
      toggleValue: _streamSubscription.isPaused,
      toggleAction: () =>
          HelperFunctions.toggleStream(setState, _streamSubscription),
      size: context.height * 8,
    );
  }

  Widget getAnimatedList() {
    return AnimatedList(
      key: _elementKey,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        return CoinCard(
          item: _items[index],
          animation: animation,
          isExpanded: _expandedKeys.contains(_items[index]),
          onExpansionChanged: (bool val, dynamic item) =>
              HelperFunctions.expansionChange(
                  val, item, _audioCache, _expandedKeys),
          key: UniqueKey(),
        );
      },
    );
  }
}
