import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';

class ChatView extends StatefulWidget {
  final WebsocketRepositorie repositorie;
  const ChatView({super.key, required this.repositorie});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late SupscripeMessageChannelUseCase useCase;

  @override
  void initState() {
    useCase = SupscripeMessageChannelUseCase(repositorie: widget.repositorie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          builder: (context, state) => _buildBody(context, state),
          listener: (context, state) => _triggerEvents(context, state),
        ),
      ),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    if (state is MessageRecived) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(state.message.message)),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
                onPressed: () => context.read<ChatBloc>().add(
                    SupscripeMessageChannel(channelID: "1", usecase: useCase)),
                child: const Text("Connect To Server")),
          ),
        ],
      );
    }
  }

  _triggerEvents(BuildContext context, ChatState state) {}
}
