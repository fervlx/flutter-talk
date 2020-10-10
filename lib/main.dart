import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:talk/routes/app_routes.dart';
import 'package:talk/services/auth_service.dart';
import 'package:talk/services/socket_service.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => AuthService()),
        ChangeNotifierProvider( create: ( _ ) => SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Talk',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }

}
