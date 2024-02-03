import 'package:flutter/material.dart';

class StyleConstants {
  AppBar buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
