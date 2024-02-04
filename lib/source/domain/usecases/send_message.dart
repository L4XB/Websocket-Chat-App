import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';

class SendMessageUseCase {
  WebsocketRepositorie repositorie;

  SendMessageUseCase({required this.repositorie});

  Future<void> execute(String channelID, MessageModel messageModel) async {
    await repositorie.sendMessageIntoChannel(channelID, messageModel);
  }
}
