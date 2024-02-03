import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_chat/source/config/websocket_config.dart';

class WebsocketProvider {
  WebSocketChannel connectToChannel(String channelID) {
    final wsUrl = Uri.parse(WebSocketConfig().baseURLWithRoom + channelID);
    WebSocketChannel channel = WebSocketChannel.connect(wsUrl);

    return channel;
  }

  Future<Stream> getStream(WebSocketChannel channel) async {
    await channel.ready;
    return channel.stream;
  }
}
