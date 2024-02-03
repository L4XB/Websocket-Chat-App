import 'package:flutter/material.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';

class ChatView extends StatefulWidget {
  final WebsocketRepositorie repositorie;
  const ChatView({super.key, required this.repositorie});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
