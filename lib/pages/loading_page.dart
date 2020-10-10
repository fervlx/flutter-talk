import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talk/pages/login_page.dart';
import 'package:talk/pages/users_page.dart';
import 'package:talk/services/auth_service.dart';
import 'package:talk/services/socket_service.dart';


class LoadingPage extends StatelessWidget {
  
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {
    
    return Scaffold(
      body: FutureBuilder(
        future: _checkLogin( context ),
        builder: ( _, snapshot ){
          return Container(
            child: Center(
              child: Text('Iniciando...'),
            ),
          );
        }
      ),
    );
  }


  Future _checkLogin( BuildContext context ) async {

    final _authService   = Provider.of<AuthService>( context, listen: false );
    final _socketService = Provider.of<SocketService>( context, listen: false );

    bool loggedOk = await _authService.isLoggedIn();

    if ( loggedOk ) {

      _socketService.connect();

      Navigator.pushReplacement( context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __, ___ ) => UsersPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );

    } else {

      Navigator.pushReplacement( context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __, ___ ) => LoginPage(),
          transitionDuration: Duration( milliseconds: 0 )
        )
      );
    }
  }
}