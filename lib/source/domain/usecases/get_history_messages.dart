import 'dart:convert';

import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';

class GetHistoryMessagesUseCase {
  WebsocketRepositorie repositorie;

  GetHistoryMessagesUseCase({required this.repositorie});

  Future<List<MessageModel>> execute(String channelID) async {
    String data = await repositorie.getHistoryChannelData(channelID);
    dynamic decodetData = jsonDecode(data);
    List<MessageModel> messages = [];

    for (var i in decodetData) {
      messages.add(MessageModel.fromJSON(i));
    }

    return messages;
  }
}
