import 'package:flutter/material.dart';

class AccountLabelWidget extends StatelessWidget {
  
  final String route;
  final String action;
  final String actionTitle;

  const AccountLabelWidget({Key key, 
    @required this.route, 
    @required this.action,
    @required this.actionTitle
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text( this.actionTitle, style: TextStyle( fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.w300 )),
        SizedBox( height: 4.0 ),
        GestureDetector(
          child: Text( this.action, style: TextStyle( fontSize: 17.0, color: Colors.blue, fontWeight: FontWeight.bold )),
          onTap: () {
            Navigator.pushReplacementNamed( context, this.route );
          },
        )
      ],
    );
  }
}