import 'package:flutter/material.dart';
import 'package:websocket_chat/source/presentation/views/testing.dart';

class WebSocketChat extends StatelessWidget {
  const WebSocketChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Testing(),
    );
  }
}
