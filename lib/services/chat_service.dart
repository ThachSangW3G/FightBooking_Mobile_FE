import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatService {
  final WebSocketChannel channel;

  ChatService(String url) : channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<Map<String, dynamic>> get messages => channel.stream.map((event) {
        final decoded = jsonDecode(event);
        return decoded;
      });

  void sendMessage(String senderId, String receiverId, String message) {
    final msg = jsonEncode({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'createdAt': DateTime.now().toIso8601String()
    });
    channel.sink.add(msg);
  }

  void dispose() {
    channel.sink.close(status.goingAway);
  }
}
