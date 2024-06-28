import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _messagesController =
      StreamController<Map<String, dynamic>>.broadcast();

  ChatService(String url)
      : _channel = WebSocketChannel.connect(Uri.parse(url)) {
    _channel.stream.listen((data) {
      final decodedData = jsonDecode(data as String);
      _messagesController.add(decodedData);
    });
  }

  Stream<Map<String, dynamic>> get messages => _messagesController.stream;

  void sendMessage(String userId, String receiverId, String message) {
    final createdAt = DateTime.now().toIso8601String();
    final data = jsonEncode({
      'senderId': userId,
      'receiverId': receiverId,
      'message': message,
      'createdAt': createdAt,
    });
    _channel.sink.add(data);
  }

  Future<List<Map<String, dynamic>>> getChatHistory(
      String userId, String adminId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.8:7050/api/messages/history/$userId/$adminId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print('Chat history response: $data'); // Log the response for debugging
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load chat history');
    }
  }

  void dispose() {
    _channel.sink.close();
    _messagesController.close();
  }
}
