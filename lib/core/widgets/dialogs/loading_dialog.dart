import 'package:flutter/material.dart';

import '../../core_shelf.dart';

/// Dialog Builder class helps to show a dialog on a screen.
class DialogBuilder {
  final BuildContext context;
  const DialogBuilder(this.context);

  /// Shows a loading dialog by using the [LoadingIndicator] widget as its content.
  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: context.lowCircular),
            backgroundColor: Colors.grey[300],
            content: const LoadingIndicator(),
          ),
        );
      },
    );
  }
}

/// Loading Indicator widget contains a circular progress indicator and loading text.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.mediumEdgeInsets,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(context),
          _getHeading(context),
        ],
      ),
    );
  }

  /// Circular progress indicator with custom settings and padding.
  Padding _getLoadingIndicator(BuildContext context) {
    return Padding(
      padding: context.bottomMedium,
      child: SizedBox(
        width: context.height * 6,
        height: context.height * 6,
        child: Center(
          child: CircularProgressIndicator(
            color: context.accentColor,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  /// Loading text with a custom padding and settings.
  Widget _getHeading(BuildContext context) {
    return Padding(
      padding: context.bottomLow,
      child: Text(
        'Please wait...',
        style: TextStyle(color: Colors.black87, fontSize: context.fontSize * 3),
        textAlign: TextAlign.center,
      ),
    );
  }
}
