import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String title;
  final void Function() onPressButton;

  ButtonWidget({ 
    @required this.title, 
    @required this.onPressButton 
  });

  @override
  Widget build( BuildContext context ) {
    return RaisedButton(
      elevation: 2.0,
      focusElevation: 5.0,
      shape: StadiumBorder(),
      color: Colors.blue,
      onPressed: this.onPressButton,
      child: Container(
        width: double.infinity,
        height: 50.0,
        child: Center(
          child: Text( this.title, style: TextStyle( color: Colors.white, fontSize: 17.0 )),
        ),
      ),
    );
  }
}