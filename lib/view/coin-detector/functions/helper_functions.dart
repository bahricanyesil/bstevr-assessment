import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

mixin HelperFunctions {
  static void playSound(AudioCache audioCache) {
    Future.delayed(Duration.zero, () async {
      final bytes = await (await audioCache.loadAsFile('sound/coin_sound.mp3'))
          .readAsBytes();
      await audioCache.playBytes(bytes);
    });
  }

  static void toggleStream(
      StateSetter setState, StreamSubscription<String> subs) {
    setState(() {
      subs.isPaused ? subs.resume() : subs.pause();
    });
  }

  static Stream<String> getRandomStream(GlobalKey<AnimatedListState> key,
          AudioCache audioCache, List<dynamic> items) =>
      Stream.periodic(const Duration(seconds: 3), (int val) {
        final random = Random().nextInt(2);
        if (key.currentState != null) {
          key.currentState!
              .insertItem(0, duration: const Duration(milliseconds: 500));
          items.insert(0,
              {'name': random == 0 ? 'Real' : 'Fake', 'date': DateTime.now()});
          if (random == 0) playSound(audioCache);
        }
        return random == 0 ? 'Real' : 'Fake';
      });

  static bool expansionChange(
      bool val, dynamic item, AudioCache audioCache, List<dynamic> expandeds) {
    if (val && !expandeds.contains(item)) {
      expandeds.add(item);
      if (item['name'] == 'Real') playSound(audioCache);
      return true;
    } else {
      expandeds.remove(item);
      return false;
    }
  }
}
