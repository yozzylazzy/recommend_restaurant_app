import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  final WidgetBuilder portraitWidget;
  final WidgetBuilder landscapeWidget;

  const OrientationWidget(
      {Key? key, required this.portraitWidget, required this.landscapeWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    switch (orientation) {
      case Orientation.portrait:
        return portraitWidget(context);
      case Orientation.landscape:
        return landscapeWidget(context);
      default:
        return portraitWidget(context);
    }
  }
}
