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
    return BlocConsumer<ChatBloc, ChatState>(
      builder: (context, state) => _buildBody(context, state),
      listener: (context, state) => _triggerEvents(context, state),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    double scrrenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        state is ChannelAddedSuccesfully || state is ChannelsLoadedSuccefully
            ? Expanded(
                child: ListView.builder(
                  itemCount: (state as dynamic).channelNamens.length,
                  itemBuilder: (context, index) {
                    return ChannelElemnt(
                        channelName: (state as dynamic).channelNamens[index],
                        onpress: () {});
                  },
                ),
              )
            : Container(),
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
              child: const Text("Connected To Server")),
        ),
      ],
    );
  }

  _triggerEvents(BuildContext context, ChatState state) {
    if (state is ChannelAddedSuccesfully || state is ChannelsLoadedSuccefully) {
      print((state as dynamic).channelNamens.length);
    }
  }
}
