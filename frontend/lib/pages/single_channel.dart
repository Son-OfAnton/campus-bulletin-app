import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:frontend/models/message.model.dart';

class SingleChannel extends StatefulWidget {
  const SingleChannel({Key? key}) : super(key: key);

  @override
  _SingleChannelState createState() => _SingleChannelState();
}

class _SingleChannelState extends State<SingleChannel> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [
    'Hello',
  ];
  // final List<Map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Single Channel',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.all(10),
                  backGroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    _messages[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: _messageController.text.isEmpty ? null : 2,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onChanged: (text) => {
                setState(() {
                  _messageController.text.isEmpty
                      ? null
                      : _messageController.text;
                })
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
            iconSize: 32,
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(messageText);
        _messageController.clear();
      });
    }
  }
}
