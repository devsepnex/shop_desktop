import 'dart:developer';
import 'package:flutter/material.dart';

class ResponseDetector extends StatelessWidget {
  const ResponseDetector(
      {super.key,
      required this.screenWindows,
      required this.screenTab,
      required this.screenMob});

  final Widget screenWindows;
  final Widget screenMob;
  final Widget screenTab;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log('Screen Width => ${constraints.maxWidth}');
        if (constraints.maxWidth > 1024) {
          return screenWindows;
        } else if (constraints.maxWidth > 580 && constraints.maxWidth <= 1024) {
          return screenTab;
        } else
          return screenMob;
      },
    );
  }
}
