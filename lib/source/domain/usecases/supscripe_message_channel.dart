import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';

class SupscripeMessageChannelUseCase {
  WebsocketRepositorie repositorie;

  SupscripeMessageChannelUseCase({required this.repositorie});

  Future<Stream> execute(String channelID) async {
    Stream stream = await repositorie.connectToWebSocketServer(channelID);

    return stream;
  }
}
