import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/core_shelf.dart';

class CoinCard extends StatefulWidget {
  final dynamic item;
  final Animation<double> animation;
  final bool isExpanded;
  final Function(bool, dynamic) onExpansionChanged;
  const CoinCard(
      {Key? key,
      required this.item,
      required this.animation,
      required this.isExpanded,
      required this.onExpansionChanged})
      : super(key: key);

  @override
  _CoinCardState createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  late AnimationController _animationController;
  Timer? _timer;
  late bool _isExpanded = widget.isExpanded;

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

  Widget _getExpansionTile() => ExpansionTile(
        initiallyExpanded: _isExpanded,
        title: _getTitle(),
        children: _getChildren(),
        onExpansionChanged: _localExpansionChanged,
        trailing: _getTrailing(),
      );

  Widget _getTitle() => Container(
        alignment: Alignment.center,
        height: context.height * 8,
        child: AutoSizeText(
          'Coin is ${widget.item['name']}',
          style: Theme.of(context).textTheme.headline4!,
          textAlign: TextAlign.center,
        ),
      );

  List<Widget> _getChildren() => [
        AutoSizeText(
          Utils.dateDiffHelper(widget.item['date']),
          textAlign: TextAlign.center,
        ),
      ];

  Widget _getTrailing() => RotationTransition(
        turns: _animationController.drive(_halfTween.chain(_easeInTween)),
        child: Padding(
          padding: context.topLow,
          child: const Icon(Icons.expand_more),
        ),
      );

  void _localExpansionChanged(bool val) {
    setState(() {
      _isExpanded = val;
      widget.onExpansionChanged(val, widget.item);
    });
  }
}
