import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/new_message.dart';
import '../widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
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
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            Divider(),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Firestore.instance
      //           .collection('/chats/Q4v8GN45Y1jrRDxsd8X4/messages')
      //           .add({'text': 'This was added by clicking the button!'});
      //     }),
    );
  }
}

// StreamBuilder(
//         stream: Firestore.instance
//             .collection('/chats/Q4v8GN45Y1jrRDxsd8X4/messages')
//             .snapshots(),
//         builder: (context, streamSnapshot) {
//           if (streamSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final documents = streamSnapshot.data.documents;
//           return ListView.builder(
//             itemBuilder: (context, index) => Container(
//               padding: EdgeInsets.all(
//                 9,
//               ),
//               child: Text(
//                 documents[index]['text'],
//               ),
//             ),
//             itemCount: documents.length,
//           );
//         },
//       ),
