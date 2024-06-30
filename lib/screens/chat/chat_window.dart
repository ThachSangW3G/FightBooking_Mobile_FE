import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/services/chat_service.dart';
import 'employee_chat_view.dart';
import 'ai_chatbot_view.dart';

class ChatWindow extends StatefulWidget {
  final VoidCallback onClose;
  final String userId;

  const ChatWindow({Key? key, required this.onClose, required this.userId})
      : super(key: key);

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  final TextEditingController _controller = TextEditingController();
  late ChatService _chatService;
  final String _adminId = "1"; // Assuming admin ID is 1

  @override
  void initState() {
    super.initState();
    _chatService = ChatService('ws://192.168.1.8:7050/ws');
  }

  @override
  void dispose() {
    _chatService.dispose();
    _controller.dispose();
    super.dispose();
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
                EmployeeChatView(
                  userId: widget.userId,
                  adminId: _adminId,
                  chatService: _chatService,
                  controller: _controller,
                ),
                AIChatbotView(
                  userId: widget.userId,
                  chatService: _chatService,
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
