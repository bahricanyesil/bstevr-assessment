import 'package:flutter/material.dart';

/// String extension provides an easy access to the files in the assets.
extension ImagePathExtension on String {
  String get toSVG => 'assets/svg/$this.svg';

  Image get pngImageAsset => Image.asset('assets/images/$this.png');
  Image get pngLogoAsset => Image.asset('assets/images/logo/$this.png');
  Image get pngIconAsset => Image.asset('assets/icons/$this.png');
}
