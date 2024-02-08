import 'package:flutter/material.dart';

class StyleConstants {
  AppBar buildAppBar(String title, BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 199, 156, 227),
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 23,
          ),
        ),
      ],
    );
  }
}
