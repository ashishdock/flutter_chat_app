import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  // const Messages({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot == null) {
              return Container(
                  // color: Colors.white,
                  );
            }

            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data.documents;
            print(chatDocs);
            print(chatDocs[0]['userId']);
            // print(snapshot.data.uid);
            if (chatDocs == null) {
              return Container(
                  // color: Colors.white,
                  );
            }
            if (chatDocs.length == 0) {
              return Container(
                  // color: Colors.white,
                  );
            }

            return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: chatDocs[index]['text'],
                    isMe: chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(chatDocs[index].documentID),
                    username: chatDocs[index]['username'],
                    userImage: chatDocs[index]['userImage'],
                  );
                });
          },
        );
      },
    );
  }
}

//Text(chatDocs[index]['text'])
