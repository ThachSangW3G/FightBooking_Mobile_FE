import 'package:flightbooking_mobile_fe/components/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/services/chat_service.dart';

class ChatWindow extends StatefulWidget {
  final VoidCallback onClose;
  final String userId;

  const ChatWindow({Key? key, required this.onClose, required this.userId})
      : super(key: key);

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late ChatService _chatService;
  final String _adminId = "1"; // Assuming admin ID is 1

  @override
  void initState() {
    super.initState();
    _chatService = ChatService('ws://192.168.1.6:7050/ws');
    _chatService.messages.listen((data) {
      // Check if the senderId is not equal to the userId to avoid echoing user's own messages
      if (data['senderId'] != widget.userId) {
        setState(() {
          _messages.add(ChatMessage(
            data['message'],
            MessageAlign.left,
            DateTime.parse(data['createdAt']),
          ));
        });
      }
    });
  }

  @override
  void dispose() {
    _chatService.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = _controller.text;
      final createdAt = DateTime.now().toIso8601String();
      _chatService.sendMessage(widget.userId, _adminId, message);
      setState(() {
        _messages.add(ChatMessage(message, MessageAlign.right, DateTime.now()));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: TabBar(
                tabs: [
                  Tab(text: 'Nhân viên hỗ trợ'),
                  Tab(text: 'AI Chatbot'),
                ],
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: widget.onClose,
                ),
              ],
            ),
            body: TabBarView(
              children: [
                _buildChatView(),
                _buildChatView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return Align(
                alignment: message.align == MessageAlign.right
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: message.align == MessageAlign.right
                        ? Colors.blue
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: message.align == MessageAlign.right
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: TextStyle(
                          color: message.align == MessageAlign.right
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        message.createdAt.toLocal().toString(),
                        style: TextStyle(
                          color: message.align == MessageAlign.right
                              ? Colors.white54
                              : Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập tin nhắn...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              ChatBubble(onPressed: _sendMessage),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatMessage {
  final String message;
  final MessageAlign align;
  final DateTime createdAt;

  ChatMessage(this.message, this.align, this.createdAt);
}

enum MessageAlign { left, right }
