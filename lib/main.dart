import 'package:flutter/material.dart';
import 'package:talk/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk',
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }

}
