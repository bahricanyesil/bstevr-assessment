import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Helper Functions of the coin detector screen.
mixin HelperFunctions {
  /// Reads the bytes of the sound from the asset file and
  /// plays the sound with a given [audioCache] object.
  static void playSound(AudioCache audioCache) {
    Future.delayed(Duration.zero, () async {
      final bytes = await (await audioCache.loadAsFile('sound/coin_sound.mp3'))
          .readAsBytes();
      await audioCache.playBytes(bytes);
    });
  }

  /// Toggles the stream status, pauses or resumes.
  static void toggleStream(
      StateSetter setState, StreamSubscription<String> subs) {
    setState(() {
      subs.isPaused ? subs.resume() : subs.pause();
    });
  }

  /// Returns a stream randomly prints 'Real' or 'Fake' every 3 seconds.
  /// Inserts an item to the list in the coin detector screen and also items list.
  /// [playSound] method will be called if the coin is real.
  /// Coin type will be printed if the app is not in [kReleaseMode].
  static Stream<String> getRandomStream(
    GlobalKey<AnimatedListState> key,
    AudioCache audioCache,
    List<Map<String, dynamic>> items,
    BuildContext context,
  ) =>
      Stream.periodic(const Duration(seconds: 3), (int val) {
        final random = Random().nextInt(2);
        if (key.currentState != null) {
          if (items.isEmpty) Navigator.of(context).pop();
          key.currentState!
              .insertItem(0, duration: const Duration(milliseconds: 500));
          items.insert(0,
              {'name': random == 0 ? 'Real' : 'Fake', 'date': DateTime.now()});
          if (random == 0) playSound(audioCache);
          if (!kReleaseMode) print(random == 0 ? 'Real' : 'Fake');
        }
        return random == 0 ? 'Real' : 'Fake';
      });

  /// Adds the item to the expandeds list if it expanded or removes in the reverse situation.
  /// If the item is expanded and it is real [playSound] function is called.
  /// If the app is not in [kReleaseMode], print the name of the item.
  static bool expansionChange(bool val, dynamic item, AudioCache audioCache,
      List<Map<String, dynamic>> expandeds) {
    if (val && !expandeds.contains(item)) {
      expandeds.add(item);
      if (item['name'] == 'Real') playSound(audioCache);
      if (!kReleaseMode) print(item['name']);
      return true;
    } else {
      expandeds.remove(item);
      return false;
    }
  }
}
