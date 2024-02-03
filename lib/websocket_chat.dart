import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/data/datasources/websocket_provider.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_chat/source/presentation/views/chat_view.dart';

class WebSocketChat extends StatelessWidget {
  const WebSocketChat({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = WebsocketProvider();
    final repositorie = WebsocketRepositorie(websocketProvider: provider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (context) => ChatBloc())],
          child: ChatView(repositorie: repositorie)),
    );
  }
}
