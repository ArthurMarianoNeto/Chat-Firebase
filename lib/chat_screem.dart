import 'dart:io';

import 'package:chat_firebase/text_composer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreem extends StatefulWidget {
  @override
  _ChatScreemState createState() => _ChatScreemState();
}

class _ChatScreemState extends State<ChatScreem> {

  void _senMassage({String text, File imgFile}) async{

    //Map<String, dynamic> = data {};
    Map<String, dynamic> data = {};

    if(imgFile != null){
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
    }

    Firestore.instance.collection("messages").add({
      "text": text
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá"),
        elevation: 0,
      ),
      body: TextComposer(_senMassage),
    );
  }
}
