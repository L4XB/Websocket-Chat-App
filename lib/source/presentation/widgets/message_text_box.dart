import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({super.key});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 120, 185, 245),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Nachricht eingeben',
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
