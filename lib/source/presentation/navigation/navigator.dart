import 'package:flutter/material.dart';

class AppNavigator {
  void pushNavigationToWidget(Widget nextPage, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  void pushNavigationToWidgetAndRemoveAll(
      Widget nextPage, BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
      (route) => false,
    );
  }
}
