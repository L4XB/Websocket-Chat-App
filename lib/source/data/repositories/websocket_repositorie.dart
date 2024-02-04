import 'package:websocket_chat/source/config/websocket_config.dart';
import 'package:websocket_chat/source/data/datasources/websocket_provider.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';

class WebsocketRepositorie {
  final WebsocketProvider websocketProvider;

  WebsocketRepositorie({required this.websocketProvider});

  Future<Stream> connectToWebSocketServer(String channelID) async {
    final currentChannel = websocketProvider.connectToChannel(
        WebSocketConfig().baseURLWithRoom, channelID);
    final stream = websocketProvider.getStream(currentChannel);

    return stream;
  }

  Future<String> getHistoryChannelData(String channelID) async {
    final currentChannel = websocketProvider.connectToChannel(
        WebSocketConfig().baseURLWithAllMessages, channelID);
    String historyData = await currentChannel.stream.first;

    currentChannel.sink.close();

    return historyData;
  }

  Future<void> sendMessageIntoChannel(
      String channelID, MessageModel messageModel) async {
    final currentChannel = websocketProvider.connectToChannel(
        WebSocketConfig().baseURLWithRoom, channelID);
    await currentChannel.ready;
    currentChannel.sink.add(messageModel.toJSON());
    currentChannel.sink.close();
  }
}
