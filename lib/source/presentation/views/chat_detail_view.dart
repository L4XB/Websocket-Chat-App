import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_detail_bloc/chat_detail_bloc.dart';

class ChatDetailView extends StatefulWidget {
  final Stream<dynamic> messageStream;
  const ChatDetailView({super.key, required this.messageStream});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleConstants().buildAppBar("Chat Page"),
      body: BlocProvider(
          create: (context) => ChatDetailBloc()
            ..add(SubscripeStream(stream: widget.messageStream)),
          child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
              builder: (context, state) => _buildBody(context, state))),
    );
  }

  Widget _buildBody(BuildContext context, ChatDetailState state) {
    if (state is MessageRecived) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(state.message.message),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
