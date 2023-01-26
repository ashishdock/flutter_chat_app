import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(
            9,
          ),
          child: Text('This works!'),
        ),
        itemCount: 10,
      ),
    );
  }
}
