import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:flutter/src/widgets/sliver.dart';


class TextComposer extends StatefulWidget {

  TextComposer(this.sendMenssage);

  final Function({String text, File imgFile}) sendMenssage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.add_a_photo_outlined),
            onPressed: () async {
            final File imgFile =
            await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
            widget.sendMenssage(imgFile: imgFile);
          },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
                decoration: InputDecoration.collapsed(hintText: "Escreva o que você quiser"),
              onChanged: (text){
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
              },
              onSubmitted: (text){
                  widget.sendMenssage(text: text);
                  _reset();
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send, // color: Colors.deepOrange,
              ),
              onPressed: _isComposing ? (){
                widget.sendMenssage(text: _controller.text);
                _reset();
              } : null,
          ),
        ],
      ),
    );
  }
}
