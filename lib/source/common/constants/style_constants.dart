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

  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 199, 156, 227),
        ),
      ),
    );
  }
}
