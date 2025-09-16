import 'dart:math';
import 'package:flutter/material.dart';
import 'callscreen.dart'; // import the call screen

class chatscreen extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const chatscreen({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<chatscreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<chatscreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, {
        "id": "${Random().nextInt(1000) + 1}",
        "text": _textController.text,
        "isSender": true,
        "time":
            "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
      });
    });

    _textController.clear();

    // Simulate reply
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, {
          "id": "${Random().nextInt(1000) + 1}",
          "text": "Got it 👍",
          "isSender": false,
          "time":
              "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          title: Text(
            widget.userName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: IconButton(
                  icon: const Icon(Icons.call, color: Colors.black, size: 18),
                  onPressed: () {
                    // Navigate to callscreen and pass user data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => callscreen(
                          userName: widget.userName,
                          userAvatar: widget.userAvatar,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              reverse: true, // latest message at bottom
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(
                  isSender: msg["isSender"],
                  message: msg["text"],
                  time: msg["time"],
                  avatar: msg["isSender"] ? null : widget.userAvatar,
                );
              },
            ),
          ),

          // Input bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_emotions_outlined,
                            color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: "Type something...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Icon(Icons.attach_file, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable ChatBubble
class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;
  final String? avatar;

  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.time,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSender && avatar != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(avatar!),
            ),
          ),
        Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isSender ? Colors.orange : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:
                      isSender ? const Radius.circular(16) : Radius.zero,
                  bottomRight:
                      isSender ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (isSender)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.done_all, size: 16, color: Colors.grey),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
