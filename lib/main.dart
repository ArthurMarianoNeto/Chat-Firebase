import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
//  Firestore.instance.collection("col").document("doc").setData({"texto":"Arthur"});
    Firestore.instance.collection("mensagens").document("msg2").setData({
      "texto": "Estou bem demais",
      "from":  "Joaquina",
      "read": false
    });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(),
    );
  }
}

