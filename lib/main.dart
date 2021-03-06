import 'package:chat_firebase/chat_screem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MyApp());
//  Firestore.instance.collection("col").document("doc").setData({"texto":"Arthur"});
/*    Firestore.instance.collection("mensagens").document().setData({
      "texto": "Testando chave aleatoria",
      "from":  "Jacira",
      "read": false
    });
*/
/*  QuerySnapshot snapshot = await Firestore.instance.collection("mensagens").getDocuments();
  snapshot.documents.forEach((d){
  print(d.data);
  });
*/
/*
  DocumentSnapshot snapshot = await Firestore.instance.collection("mensagens")
      .document("qkpgBhmn7dAKp4J8xEf1").get();
   print(snapshot.data);
*/
/*
  Firestore.instance.collection("mensagens").snapshots().listen((dado){
    dado.documents.forEach((d){
    print(d.data);
    });
  });
*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreem(),
    );
  }
}

