import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String message;
  final String uuid;
  final AnimationController animationController;

  const ChatMessage({Key key, 
    @required this.message, 
    @required this.uuid,
    @required this.animationController 
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation( parent: animationController, curve: Curves.easeOut ),
        child: Container(
          child: this.uuid == '123'
            ? _messageSent()
            : _messageReceived(),
        ),
      ),
    );
  }

  Widget _messageSent() {

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only( right: 8.0, left: 50, bottom: 8.0 ),
        padding: const EdgeInsets.symmetric( horizontal: 14.0, vertical: 8.0 ),
        decoration: BoxDecoration(
          color: Colors.purple[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        child: Text( this.message, style: TextStyle( color: Colors.white )),
      ),
    );
  }

  Widget _messageReceived() {

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only( right: 50.0, left: 8.0, bottom: 8.0 ),
        padding: const EdgeInsets.symmetric( horizontal: 14.0, vertical: 8.0 ),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Text( this.message, style: TextStyle( color: Colors.black87 )),
      ),
    );
  }
}