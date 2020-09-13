import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInputWidget({Key key,
    @required this.icon,
    @required this.placeholder,
    @required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.only( left: 5.0, top: 5.0, bottom: 5.0, right: 20.0 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 30.0 ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity( 0.07 ),
            offset: Offset( 0, 5 ),
            blurRadius: 5.0
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: this.keyboardType,
        controller: this.textController,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon( this.icon ), 
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        ),
      ),
    );
  }
}