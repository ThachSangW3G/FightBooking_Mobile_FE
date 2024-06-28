import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flightbooking_mobile_fe/services/chat_service.dart';

class AIChatbotView extends StatefulWidget {
  final String userId;
  final ChatService chatService;
  final TextEditingController controller;

  const AIChatbotView({
    Key? key,
    required this.userId,
    required this.chatService,
    required this.controller,
  }) : super(key: key);

  @override
  _AIChatbotViewState createState() => _AIChatbotViewState();
}

class _AIChatbotViewState extends State<AIChatbotView> {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  late GenerativeModel model;

  @override
  void initState() {
    super.initState();
    final apiKey =
        'AIzaSyDPQ7fBApgLPSWsRLf6dSCX7aipnzJOtwY'; // Replace with your actual API key
    model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  void _sendMessage() async {
    if (widget.controller.text.isNotEmpty) {
      final message = widget.controller.text;
      setState(() {
        _messages.add(ChatMessage(message, MessageAlign.right, DateTime.now()));
        _isLoading = true;
      });
      widget.controller.clear();

      final response = await _fetchChatGptResponse(message);

      setState(() {
        _isLoading = false;
        if (response != null) {
          _messages
              .add(ChatMessage(response, MessageAlign.left, DateTime.now()));
        } else {
          _messages.add(ChatMessage(
              'Failed to get response', MessageAlign.left, DateTime.now()));
        }
      });
    }
  }

  Future<String?> _fetchChatGptResponse(String message) async {
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    return response.text;
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
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
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
