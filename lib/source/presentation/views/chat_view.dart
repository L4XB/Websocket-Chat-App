import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_chat/source/presentation/navigation/navigator.dart';
import 'package:websocket_chat/source/presentation/views/chat_detail_view.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_widgets/home_default_layout.dart';

class ChatView extends StatefulWidget {
  final WebsocketRepositorie repositorie;
  const ChatView({super.key, required this.repositorie});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late SupscripeMessageChannelUseCase useCase;
  late TextEditingController channelController;

  @override
  void initState() {
    useCase = SupscripeMessageChannelUseCase(repositorie: widget.repositorie);
    channelController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleConstants().buildAppBar("Connect to Server"),
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: BlocConsumer<ChatBloc, ChatState>(
          builder: (context, state) => _buildBody(context, state),
          listener: (context, state) => _triggerEvents(context, state),
        ),
      ),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    return HomeDefaultLayout(
        channelController: channelController, useCase: useCase);
  }

  _triggerEvents(BuildContext context, ChatState state) {
    if (state is SubscriptionSuccesfull) {
      debugPrint("Succefully Connected");
      AppNavigator().pushNavigationToWidget(
          ChatDetailView(
              messageStream: state.messageStream,
              repositorie: widget.repositorie,
              channelID: channelController.text),
          context);
    }
  }
}
