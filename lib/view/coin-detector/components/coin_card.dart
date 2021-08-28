import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

/// Coin card component for the automated coin detector screen.
/// It is used as a main widget in the list of the screen.
class CoinCard extends StatefulWidget {
  /// Item map that contains some info about the coin.
  final Map<String, dynamic> item;

  /// Animation specific to the coin card.
  final Animation<double> animation;

  /// Controls whether the card is expanded for more info or not.
  final bool isExpanded;

  /// Function what will be called on expansion change.
  final Function(bool, dynamic) onExpansionChanged;
  const CoinCard({
    Key? key,
    required this.item,
    required this.animation,
    required this.isExpanded,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard>
    with SingleTickerProviderStateMixin {
  /// Ease in Tween animation type with ease in curve.
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  /// Half Tween animation type with specific begin and end values.
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  /// Animation controller for expansion changes.
  late AnimationController _animationController;

  /// Timer object to update coin card every second for correct date difference info.
  Timer? _timer;

  /// Controls the expansion status of the card locally.
  late bool _isExpanded = widget.isExpanded;

  /// Assigning the initial values of [_animationController] and [_timer].
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: context.tooFast, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        setState(() {});
      });
    });
  }

  /// Cancels the [_timer] if it is assigned to a value.
  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:
          SlideTransitionAnimations.coinDetectorAnimation(widget.animation),
      child: FadeTransition(
        opacity: widget.animation,
        child: Card(
          color: widget.item['name'] == 'Real' ? Colors.green : Colors.red,
          child: _getExpansionTile(),
        ),
      ),
    );
  }

  /// Returns the [ExpansionTile] object with custom values.
  Widget _getExpansionTile() => ExpansionTile(
        initiallyExpanded: _isExpanded,
        title: _getTitle(),
        children: _getChildren(),
        onExpansionChanged: _localExpansionChanged,
        trailing: _getTrailing(),
      );

  /// Returns the title of the expansion tile with a custom height and style.
  Widget _getTitle() => Container(
        alignment: Alignment.center,
        height: context.height * 8,
        child: AutoSizeText(
          'Coin is ${widget.item['name']}',
          style: Theme.of(context).textTheme.headline4!,
          textAlign: TextAlign.center,
        ),
      );

  /// Returns the children of the expansion tile.
  List<Widget> _getChildren() => [
        AutoSizeText(
          Utils.dateDiffHelper(widget.item['date']),
          textAlign: TextAlign.center,
        ),
      ];

  /// Returns the trailing icon of the expansion tile with a rotation animation.
  Widget _getTrailing() => RotationTransition(
        turns: _animationController.drive(_halfTween.chain(_easeInTween)),
        child: Padding(
          padding: context.topLow,
          child: const Icon(Icons.expand_more),
        ),
      );

  /// Controls the expansion change locally and only updates the specific card not the screen.
  void _localExpansionChanged(bool val) {
    setState(() {
      _isExpanded = val;
      widget.onExpansionChanged(val, widget.item);
    });
  }
}
