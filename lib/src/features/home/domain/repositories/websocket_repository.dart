import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketRepository {
  final WebSocketChannel channel;

  WebSocketRepository(String url)
      : channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<dynamic> get dataStream => channel.stream;

  void send(String message) {
    channel.sink.add(message);
  }

  void dispose() {
    channel.sink.close();
  }
}
