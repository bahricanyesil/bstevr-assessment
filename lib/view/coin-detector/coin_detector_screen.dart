import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/core_shelf.dart';
import 'components/components_shelf.dart';
import 'functions/functions_shelf.dart';

class CoinDetectorScreen extends StatefulWidget {
  const CoinDetectorScreen({Key? key}) : super(key: key);

  @override
  _CoinDetectorScreenState createState() => _CoinDetectorScreenState();
}

class _CoinDetectorScreenState extends State<CoinDetectorScreen> {
  /// Element Key to control the state of the [AnimatedList]
  final GlobalKey<AnimatedListState> _elementKey =
      GlobalKey<AnimatedListState>();

  /// Items that store information about the elements of [AnimatedList]
  final List<Map<String, dynamic>> _items = [];

  /// Stream produces random data every 3 seconds
  late Stream<String> _randomStream;

  /// [StreamController] that controls the [_randomStream] to pause/resume.
  final StreamController<String> _streamController =
      StreamController.broadcast();

  /// [StreamSubscription]  to pause/resume the [_randomStream].
  late StreamSubscription<String> _streamSubscription;

  /// [AudioPlayer] object constructed specific to this screen
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// [AudioCache] object with a fixed [_audioPlayer] to play a sound.
  late final AudioCache _audioCache;

  /// The list of items that are expanded to display more info.
  final List<Map<String, dynamic>> _expandedKeys = [];

  /// Initializes the required variables such as [_audioCache] and subscribe to the [_randomStream].
  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    _randomStream = HelperFunctions.getRandomStream(
        _elementKey, _audioCache, _items, context);
    _streamSubscription = _randomStream.listen(_streamController.add);
    if (kIsWeb) return;
    if (Platform.isIOS) {
      _audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
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

  /// Shows loading indicator until [_items] has at least one element.
  /// If the list has items, returns a [Scaffold] wrapped with a [SafeArea].
  Widget getSafeArea(AsyncSnapshot snapshot, List<Widget> children) {
    if (children.isEmpty && _items.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        DialogBuilder(context).showLoadingIndicator();
      });
    }
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

  /// Get the [CustomAppBar] widget with the customized values.
  CustomAppBar getAppBar(AsyncSnapshot snapshot) {
    return CustomAppBar(
      title: snapshot.data ?? '',
      toggleValue: _streamSubscription.isPaused,
      toggleAction: () =>
          HelperFunctions.toggleStream(setState, _streamSubscription),
      size: context.height * 8,
    );
  }

  /// Gets the [AnimatedList] with the customized values.
  /// Animated list contains [CoinCard] widget as its children.
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
