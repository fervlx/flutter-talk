
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


showLoginAlert({ @required BuildContext context, @required String title, @required String content }) {

  if ( Platform.isAndroid ) {

    return showDialog(
      context: context,
      builder: ( _ ) => AlertDialog(
        title   : Text( title ),
        content : Text( content ),
        actions : [
          FlatButton(
            child: Text('Aceptar'),
            textColor: Colors.blue,
            onPressed: () => Navigator.pop( context ), 
          )
          // MaterialButton(
          //   child : Text('Aceptar'),
          //   color : Colors.blue,
          //   elevation : 5.0,
          //   onPressed : () => Navigator.pop( context ),
          // ),
        ],
      )
    );
  }
  
   return showCupertinoDialog(
    context : context, 
    builder : ( _ ) => CupertinoAlertDialog(
      title   :  Text( title ),
      content : Text( content ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Aceptar'),
          onPressed: () => Navigator.pop( context ),
        ),
      ],
    )
  );
}