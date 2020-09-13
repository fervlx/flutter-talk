import 'package:flutter/material.dart';

import 'package:talk/pages/chat_page.dart';
import 'package:talk/pages/loading_page.dart';
import 'package:talk/pages/login_page.dart';
import 'package:talk/pages/register_page.dart';
import 'package:talk/pages/users_page.dart';

Map<String, Widget Function( BuildContext ) > appRoutes = {
  'login'  : ( _ ) => LoginPage(),
  'users'  : ( _ ) => UsersPage(),
  'chat'   : ( _ ) => ChatPage(),
  'register' : ( _ ) => RegisterPage(),
  'loading'  : ( _ ) => LoadingPage(),
};