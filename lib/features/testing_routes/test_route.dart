import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String _message = '';

  @override
  void initState() {
    super.initState();
    _fetchMessage();
  }

  Future<void> _fetchMessage() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.5:5000/message'));

    if (response.statusCode == 200) {
      setState(() {
        _message = jsonDecode(response.body)['message'];
      });
    } else {
      setState(() {
        _message = 'Failed to fetch message';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flask Message'),
      ),
      body: Center(
        child: _message.isNotEmpty
            ? Text(
                _message,
                style: const TextStyle(fontSize: 18),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
