import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/services/chat_service.dart';

class EmployeeChatView extends StatefulWidget {
  final String userId;
  final String adminId;
  final ChatService chatService;
  final TextEditingController controller;

  const EmployeeChatView({
    Key? key,
    required this.userId,
    required this.adminId,
    required this.chatService,
    required this.controller,
  }) : super(key: key);

  @override
  _EmployeeChatViewState createState() => _EmployeeChatViewState();
}

class _EmployeeChatViewState extends State<EmployeeChatView> {
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    widget.chatService.messages.listen((data) {
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
    _fetchChatHistory();
  }

  void _fetchChatHistory() async {
    try {
      final history = await widget.chatService
          .getChatHistory(widget.userId, widget.adminId);
      setState(() {
        _messages.addAll(history.map((msg) {
          final String message = msg['message'] as String;
          final String senderId = msg['senderId'].toString();
          final DateTime createdAt =
              DateTime.fromMillisecondsSinceEpoch(msg['createdAt'] as int);
          return ChatMessage(
            message,
            senderId == widget.userId ? MessageAlign.right : MessageAlign.left,
            createdAt,
          );
        }).toList());
      });
    } catch (e) {
      print('Error fetching chat history: $e');
    }
  }

  void _sendMessage() {
    if (widget.controller.text.isNotEmpty) {
      final message = widget.controller.text;
      final createdAt = DateTime.now().toIso8601String();
      widget.chatService.sendMessage(widget.userId, widget.adminId, message);
      setState(() {
        _messages.add(ChatMessage(message, MessageAlign.right, DateTime.now()));
      });
      widget.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập tin nhắn...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
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
