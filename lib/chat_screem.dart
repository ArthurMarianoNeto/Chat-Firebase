import 'dart:io';

import 'package:chat_firebase/chat_message.dart';
import 'package:chat_firebase/text_composer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreem extends StatefulWidget {
  @override
  _ChatScreemState createState() => _ChatScreemState();
}

class _ChatScreemState extends State<ChatScreem> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseUser _currentUser;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {

    if(_currentUser != null) return _currentUser;

    try{
        final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential( // aqui o provider é fornecido pelo google
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
        );

        final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

        final FirebaseUser user = authResult.user;

        return user;

    }catch(error){
      return null;
    }
  }

  void _sendMenssage({String text, File imgFile}) async{

    final FirebaseUser user = await _getUser();

    if(user == null){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text("Não foi possível autenticar usuário!"),
          backgroundColor: Colors.yellowAccent,
        )
      );
    }

    //Map<String, dynamic> = data {};
    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl,
      "time": Timestamp.now(), 
    };

    if(imgFile != null){
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        user.uid + DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      setState(() {
        _isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
//      print(url);
      data["imgUrl"] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if(text != null) data["text"] = text;
    Firestore.instance.collection("messages").add(data);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _currentUser != null ? "Olá ${_currentUser.displayName}" : "App Chat Flutter"
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          _currentUser != null ? IconButton(
              icon: Icon(Icons.exit_to_app_sharp),
              onPressed: (){
                FirebaseAuth.instance.signOut();
                googleSignIn.signOut();
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text("Logout realizado com sucesso!"),
  //                    backgroundColor: Colors.yellowAccent,
                    )
                );
              },
    ) : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('messages').orderBy("time").snapshots(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data.documents.reversed.toList();
                 return ListView.builder(
                  itemCount: documents.length,
                  reverse: true,
                  itemBuilder: (context, index){
                    return ChatMessage(
                      documents[index].data,
                      documents[index].data["uid"] ==  _currentUser?.uid
                    );
                    }
                 );
                  }
                },
              ),
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMenssage),
        ],
      ),
    );
  }
}
