import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketProvider {
  WebSocketChannel connectToChannel(String baseURL, String channelID) {
    final wsUrl = Uri.parse(baseURL + channelID);
    WebSocketChannel channel = WebSocketChannel.connect(wsUrl);

    return channel;
  }

  Future<Stream> getStream(WebSocketChannel channel) async {
    await channel.ready;
    return channel.stream;
  }
}
