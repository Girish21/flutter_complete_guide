import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('chats/oiofaipSia7ngn8cEQyu/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            itemBuilder: (context, index) {
              final document = snapshot.data.documents[index];

              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('${document['text']}'),
                alignment: Alignment.centerRight,
              );
            },
            itemCount: snapshot.data.documents.length,
            reverse: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/oiofaipSia7ngn8cEQyu/messages')
              .add({
            'text': 'Hello from app',
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
