import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160.0,
        margin: const EdgeInsets.only( top: 50.0 ),
        child: Column(
          children: [
            Image(image: AssetImage( 'assets/tag-logo.png' )),
            SizedBox( height: 16.0 ),
            Text('Talk', style: TextStyle( fontSize: 26.0 ))
          ],
        )
      ),
    );
  }
}