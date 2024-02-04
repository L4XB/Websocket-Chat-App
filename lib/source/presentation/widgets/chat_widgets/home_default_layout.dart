import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_widgets/channel_element.dart';

class HomeDefaultLayout extends StatelessWidget {
  final TextEditingController channelController;
  final SupscripeMessageChannelUseCase useCase;
  const HomeDefaultLayout(
      {super.key, required this.channelController, required this.useCase});

  @override
  Widget build(BuildContext context) {
    double scrrenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChannelElemnt(channelName: "1", onpress: () {}),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: scrrenWidth * 0.6,
              child: TextField(
                controller: channelController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
        ),
        Center(
          child: OutlinedButton(
              onPressed: () => context.read<ChatBloc>().add(
                  SupscripeMessageChannel(
                      channelID: channelController.text, usecase: useCase)),
              child: const Text("Connect To Server")),
        ),
      ],
    );
  }
}
