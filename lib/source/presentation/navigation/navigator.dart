import 'package:flutter/material.dart';

class AppNavigator {
  void pushNavigationToWidget(Widget nextPage, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }
}
