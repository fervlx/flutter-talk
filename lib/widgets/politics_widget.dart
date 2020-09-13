import 'package:flutter/material.dart';

class PoliticsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Términos y condiciones de uso', style: TextStyle( fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w300 )),
    );
  }
}