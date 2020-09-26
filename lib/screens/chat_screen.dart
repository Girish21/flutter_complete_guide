import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/message_input.dart';
import '../widgets/chat/messages.dart';

class ChatScreeen extends StatefulWidget {
  @override
  _ChatScreeenState createState() => _ChatScreeenState();
}

class _ChatScreeenState extends State<ChatScreeen> {
  @override
  void initState() {
    super.initState();

    var fm = FirebaseMessaging();
    fm.requestNotificationPermissions();
    fm.configure(
      onMessage: (message) {
        print(message);
        return Future.value(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new),
                      SizedBox(width: 8.0),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) async {
              switch (value) {
                case 'logout':
                  await FirebaseAuth.instance.signOut();
                  break;
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
