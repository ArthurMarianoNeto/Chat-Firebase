import 'package:chat_firebase/text_composer.dart';
import 'package:flutter/material.dart';

class ChatScreem extends StatefulWidget {
  @override
  _ChatScreemState createState() => _ChatScreemState();
}

class _ChatScreemState extends State<ChatScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá"),
        elevation: 0,
      ),
      body: TextComposer((text){
        print(text);
      }
      ),
    );
  }
}
