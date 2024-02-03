import 'package:flutter/material.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({super.key});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleConstants().buildAppBar("Chat Page"),
    );
  }
}
