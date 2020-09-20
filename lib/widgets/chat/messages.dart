import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chat').snapshots(),
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

            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('${document['text']}'),
              alignment: Alignment.centerRight,
            );
          },
        );
      },
    );
  }
}
