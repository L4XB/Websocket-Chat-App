import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/usecases/get_history_messages.dart';
import 'package:websocket_chat/source/domain/usecases/send_message.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_detail_bloc/chat_detail_bloc.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_detail_widgets/messages_recived_layout.dart';

class ChatDetailView extends StatefulWidget {
  final WebsocketRepositorie repositorie;
  final Stream<dynamic> messageStream;
  final String channelID;
  const ChatDetailView(
      {super.key,
      required this.messageStream,
      required this.channelID,
      required this.repositorie});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  /// [usecases]
  late SendMessageUseCase sendMessageUseCase;
  late GetHistoryMessagesUseCase usecase;

  /// [controller]
  late TextEditingController messageInputController;
  ScrollController scrollController = ScrollController();

  List<MessageModel> messages = [];

  @override
  void initState() {
    usecase = GetHistoryMessagesUseCase(repositorie: widget.repositorie);
    sendMessageUseCase = SendMessageUseCase(repositorie: widget.repositorie);
    messageInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleConstants().buildAppBar("Gruppe ${widget.channelID}"),
      body: BlocProvider(
          create: (context) => ChatDetailBloc()
            ..add(
              LoadHistoryMessages(
                  channelID: widget.channelID, useCase: usecase),
            ),
          child: BlocConsumer<ChatDetailBloc, ChatDetailState>(
            builder: (context, state) => _buildBody(context, state),
            listener: (context, state) => _triggerEvents(context, state),
          )),
    );
  }

  Widget _buildBody(BuildContext context, ChatDetailState state) {
    if (state is HistoryMessagesRecieved || state is MessageRecived) {
      return RecivedMessagesLayout(
          channelID: widget.channelID,
          messageInputController: messageInputController,
          messages: messages,
          scrollController: scrollController,
          sendMessageUseCase: sendMessageUseCase);
    } else {
      return Container();
    }
  }

  _triggerEvents(BuildContext context, ChatDetailState state) {
    if (state is HistoryMessagesRecieved) {
      messages = state.historyMessages;
      context
          .read<ChatDetailBloc>()
          .add(SubscripeStream(stream: widget.messageStream));
    }

    if (state is MessageRecived) {
      messages.add(state.message);
    }
  }
}
