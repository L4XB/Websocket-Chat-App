import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  final Function() onPress;
  final TextEditingController controller;
  const MessageInputField(
      {super.key, required this.onPress, required this.controller});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Schreiben...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              widget.onPress();
            },
          ),
        ),
      ),
    );
  }
}
