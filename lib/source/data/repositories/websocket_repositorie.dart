import 'package:websocket_chat/source/data/datasources/websocket_provider.dart';

class WebsocketRepositorie {
  final WebsocketProvider websocketProvider;

  WebsocketRepositorie({required this.websocketProvider});

  Future<Stream> connectToWebSocketServer(String channelID) async {
    final currentChannel = websocketProvider.connectToChannel(channelID);
    final stream = websocketProvider.getStream(currentChannel);

    return stream;
  }
}
