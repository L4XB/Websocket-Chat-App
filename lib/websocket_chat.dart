import 'package:flutter/material.dart';
import 'package:websocket_chat/source/data/datasources/websocket_provider.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/presentation/views/chat_view.dart';

class WebSocketChat extends StatelessWidget {
  const WebSocketChat({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = WebsocketProvider();
    final repositorie = WebsocketRepositorie(websocketProvider: provider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatView(repositorie: repositorie),
    );
  }
}