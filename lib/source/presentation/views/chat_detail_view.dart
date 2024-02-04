import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/entities/user_model.dart';
import 'package:websocket_chat/source/domain/usecases/get_history_messages.dart';
import 'package:websocket_chat/source/domain/usecases/send_message.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_detail_bloc/chat_detail_bloc.dart';
import 'package:websocket_chat/source/presentation/widgets/message_element_other_user.dart';
import 'package:websocket_chat/source/presentation/widgets/message_text_box.dart';

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
  late SendMessageUseCase sendMessageUseCase;
  late GetHistoryMessagesUseCase usecase;

  List<MessageModel> messages = [];
  late TextEditingController messageInputController;
  ScrollController scrollController = ScrollController();

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
      return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (messages[index].userName == UserModel().userName) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MessageBubble(
                            isAppUser: true,
                            userName: messages[index].userName,
                            message: messages[index].message,
                          )
                        ],
                      ),
                    );
                  } else {
                    return MessageBubble(
                      isAppUser: false,
                      userName: messages[index].userName,
                      message: messages[index].message,
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MessageInputField(
                controller: messageInputController,
                onPress: () {
                  MessageModel appUser = MessageModel(
                      id: "",
                      userName: UserModel().userName,
                      message: messageInputController.text);
                  context.read<ChatDetailBloc>().add(SendMessage(
                      channelID: widget.channelID,
                      messageModel: appUser,
                      useCase: sendMessageUseCase));
                }),
          ),
        ],
      );
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
