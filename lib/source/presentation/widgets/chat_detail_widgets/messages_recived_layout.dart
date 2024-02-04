import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/entities/user_model.dart';
import 'package:websocket_chat/source/domain/usecases/send_message.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_detail_bloc/chat_detail_bloc.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_detail_widgets/message_element_other_user.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_detail_widgets/message_text_box.dart';

class RecivedMessagesLayout extends StatelessWidget {
  final ScrollController scrollController;
  final List<MessageModel> messages;
  final TextEditingController messageInputController;
  final String channelID;
  final SendMessageUseCase sendMessageUseCase;
  const RecivedMessagesLayout(
      {super.key,
      required this.channelID,
      required this.messageInputController,
      required this.messages,
      required this.scrollController,
      required this.sendMessageUseCase});

  @override
  Widget build(BuildContext context) {
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
                    channelID: channelID,
                    messageModel: appUser,
                    useCase: sendMessageUseCase));
              }),
        ),
      ],
    );
  }
}
