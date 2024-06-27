import 'package:flightbooking_mobile_fe/components/chat/chat_bubble.dart';
import 'package:flightbooking_mobile_fe/screens/chat/chat_window.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  bool _isChatOpen = false;
  Offset _offset = Offset(20, 20);
  late String _userId;
  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.1.6:7050/users/token?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzYW5nMTIzNCIsImlhdCI6MTcxOTQ5NjI4OSwiZXhwIjoxNzE5NTEwNjg5fQ.CWlq-Ekiv4AkJBNJWMtSgq2iLFe3rJYpOsVK58w98BA'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _userId = data['id'].toString();
        print(_userId);
      });
    } else {
      // Handle error
      print('Failed to load username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Screen'),
      ),
      body: Stack(
        children: [
          if (_isChatOpen)
            Center(
              child: ChatWindow(
                onClose: () {
                  setState(() {
                    _isChatOpen = false;
                  });
                },
                userId: _userId,
              ),
            ),
          if (!_isChatOpen)
            Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: Draggable(
                feedback: ChatBubble(
                  onPressed: () {},
                ),
                childWhenDragging: Container(),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    _offset = offset;
                  });
                },
                child: ChatBubble(
                  onPressed: () {
                    setState(() {
                      _isChatOpen = true;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
