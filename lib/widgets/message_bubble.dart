import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  // const MessageBubble({ Key? key }) : super(key: key);
  final String message;
  final bool isMe;
  final Key key;
  final String username;

  MessageBubble({this.message, this.isMe, this.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blueGrey : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: !isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    color: isMe
                        ? Colors.yellow[300]
                        : Theme.of(context).accentTextTheme.headline1.color,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.yellow[300]
                      : Theme.of(context).accentTextTheme.headline6.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
