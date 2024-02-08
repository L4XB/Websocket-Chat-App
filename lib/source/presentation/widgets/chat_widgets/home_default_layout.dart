import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_widgets/channel_element.dart';

class HomeDefaultLayout extends StatelessWidget {
  final TextEditingController channelController;
  final WebsocketRepositorie repositorie;
  final SupscripeMessageChannelUseCase useCase;
  const HomeDefaultLayout(
      {super.key,
      required this.channelController,
      required this.useCase,
      required this.repositorie});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      builder: (context, state) => _buildBody(context, state),
      listener: (context, state) => _triggerEvents(context, state),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    double scrrenWidth = MediaQuery.of(context).size.width;
    double scrrenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        state is ChannelAddedSuccesfully || state is ChannelsLoadedSuccefully
            ? SizedBox(
                height: scrrenHeight * 0.5,
                child: ListView.builder(
                  itemCount: (state as dynamic).channelNamens.length,
                  itemBuilder: (context, index) {
                    return ChannelElemnt(
                        channelName: (state as dynamic).channelNamens[index],
                        onpress: () {
                          context.read<ChatBloc>().add(SupscripeMessageChannel(
                              channelID:
                                  (state as dynamic).channelNamens[index],
                              usecase: useCase));
                        });
                  },
                ),
              )
            : Container(),
        Expanded(
          child: SizedBox(
            width: scrrenWidth * 0.6,
            child: TextField(
              controller: channelController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
      ],
    );
  }

  _triggerEvents(BuildContext context, ChatState state) {}
}
