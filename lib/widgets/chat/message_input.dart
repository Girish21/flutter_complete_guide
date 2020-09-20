import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  var enteredMessage = '';

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Message',
              ),
              onChanged: (value) {
                setState(() {
                  enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: enteredMessage.trim().isEmpty
                ? null
                : () async {
                    _messageController.clear();
                    FocusScope.of(context).unfocus();

                    final response =
                        await Firestore.instance.collection('chat').add({
                      'text': enteredMessage,
                      'createdAt': Timestamp.now(),
                    });

                    if (response != null) {
                      setState(() {
                        enteredMessage = '';
                      });
                    }
                  },
          ),
        ],
      ),
    );
  }
}
