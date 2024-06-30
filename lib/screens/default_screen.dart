import 'dart:ffi';
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
          'https://flightbookingbe-production.up.railway.app/users/token?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0aHVvbmdzcCIsImlhdCI6MTcxOTc2MDA1OSwiZXhwIjoxNzE5Nzc0NDU5fQ.A14ebfomm0BBRsLM1gednZhs3lR-Jl_yl_sbGGKKndk'),
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
