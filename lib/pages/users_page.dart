import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:talk/models/user.dart';
import 'package:talk/services/auth_service.dart';
import 'package:talk/services/socket_servide.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  List<User> users = [
    User( uid: '1', name: 'visenya', email: 'test1@test.com', online: true ),
    User( uid: '2', name: 'valerion', email: 'test2@test.com', online: false ),
    User( uid: '3', name: 'reghal', email: 'test3@test.com', online: false ),
  ];

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {

    final _authService    = Provider.of<AuthService>( context );
    final _socketService  = Provider.of<SocketService>( context );
    
    return Scaffold(

      appBar: AppBar(
        title: Text( _authService.user.name, style: TextStyle( color: Colors.black87 )),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87 ), 
          onPressed: () {

            _socketService.disconnect();
            Navigator.pushReplacementNamed( context, 'login' );
            AuthService.deleteToken();

          }
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only( right: 10.0 ),
            child:  Icon( Icons.offline_bolt, color: Colors.red ),
            //child: Icon( Icons.check_circle, color: Colors.green ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        header: WaterDropHeader(
          complete: Icon( Icons.check_circle, color: Colors.blue[300] ),
          waterDropColor: Colors.blue[300],
        ),
        child: _usersList(),
      )
    );
  }

  ListView _usersList() {

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _ , i ) => _itemUser( users[i] ), 
      separatorBuilder: ( _ , i ) => Divider(), 
      itemCount: users.length
    );
  }

  ListTile _itemUser( User user ) {
    return ListTile(
      title: Text( user.name ),
      leading: CircleAvatar(
        child: Text( user.name.substring(0,2), style: TextStyle( color: Colors.black54 )),
        backgroundColor: Colors.blue[200],
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 100.0 ),
          color: user.online ? Colors.green[300] : Colors.red[300]
        ),
      ),
    );
  }
}