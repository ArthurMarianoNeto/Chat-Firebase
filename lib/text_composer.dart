import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMenssage);

  Function(String) sendMenssage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.add_a_photo_outlined), onPressed: (){

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
                  widget.sendMenssage(text);

              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send, color: Colors.deepOrange,),
              onPressed: _isComposing ? (){
                widget.sendMenssage(_controller.text);
              } : null,
          ),
        ],
      ),
    );
  }
}
