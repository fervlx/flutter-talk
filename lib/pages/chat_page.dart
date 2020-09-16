import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talk/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _inputCtrl = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting  = false;

  List<ChatMessage> messages = [];

  @override
  void dispose() {
    // TODO: implement dispose

    messages.forEach(( message ) { message.animationController.dispose(); });
    super.dispose();
  }

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Fv'),
              backgroundColor: Colors.blue[100],
              radius: 16.0,
            ),
            Text('Fernando Vargas', style: TextStyle( color: Colors.black87, fontSize: 14.0 ))
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: ( _ , i ) => messages[i]
            )
          ),
          
          Divider( height: 1.0 ),
          
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _inputCtrl,
                focusNode: _focusNode,
                onSubmitted: _onSubmitted,
                onChanged: ( String value ) { 
                  
                  setState(() {
                    if ( value.trim().length > 0 ){
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
              ) 
            ),
            Container(
              margin: const EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isAndroid
              
              ? Container(
                  margin: const EdgeInsets.symmetric( horizontal: 4.0 ),
                  child: IconTheme(
                    data: IconThemeData( color: Colors.blue[400] ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon( Icons.send ), 
                      onPressed: _isWriting
                        ? () => _onSubmitted( _inputCtrl.text )
                        : null
                    ),
                  )
                )
              
              : CupertinoButton(
                  child: Text( 'Enviar' ), 
                  onPressed: _isWriting
                    ? () => _onSubmitted( _inputCtrl.text )
                    : null
                ),
            )
          ],
        )
      ) 
    );
  }

  void _onSubmitted( String text ) {

    if ( text.isEmpty ) return;

    print( text );
    _inputCtrl.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage( 
      uuid: '123', 
      message: text,
      animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 330 )), 
    );
    messages.insert( 0, newMessage );
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false; 
    });
  }
}