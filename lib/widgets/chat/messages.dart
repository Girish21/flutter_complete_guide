import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message_chat_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, auth) {
        if (auth.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              reverse: true,
              itemBuilder: (context, index) {
                final document = snapshot.data.documents[index];

                return MessageChatBubble(
                  message: '${document['text']}',
                  isMe: document['userId'] == auth.data.uid,
                  key: ValueKey(
                    document.documentID,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
