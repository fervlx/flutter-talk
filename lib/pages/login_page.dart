import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:talk/helpers/login_alert.dart';
import 'package:talk/services/auth_service.dart';
import 'package:talk/services/socket_service.dart';


import 'package:talk/widgets/logo_widget.dart';
import 'package:talk/widgets/button_widget.dart';
import 'package:talk/widgets/politics_widget.dart';
import 'package:talk/widgets/custom_input_widget.dart';
import 'package:talk/widgets/account_label_widget.dart';


class LoginPage extends StatelessWidget {

  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      backgroundColor: Color( 0xffF2F2F2 ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of( context ).size.height * .95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(),
                _Form(),
                AccountLabelWidget(
                  actionTitle: '¿No tienes una cuenta?',
                  action: 'Crear una ahora!',
                  route: 'register',
                ),
                PoliticsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController paswdCtrl = TextEditingController();

  void _onTapLogin( AuthService provider, SocketService socket ) async {
    
    final status = await provider.login( email: emailCtrl.text.trim(), password: paswdCtrl.text.trim() );

    if ( status ) {
      socket.connect();
      Navigator.pushReplacementNamed( context, 'users' );
    } else {
      showLoginAlert( 
        context: context, 
        title: 'Credenciales incorrectas', 
        content: 'Por favor revise su usuario o contraseña.'
      );
    }
  }

  @override
  Widget build( BuildContext context ) {
    
    final _provider = Provider.of<AuthService>( context );
    final _socket   = Provider.of<SocketService>( context );

    return Container(
      margin: const EdgeInsets.only( top: 20.0 ),
      padding: const EdgeInsets.symmetric( horizontal: 50.0 ),
      child: Column(
        children: [
          CustomInputWidget( 
            icon: Icons.mail_outline,
            placeholder: "Correo",
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox( height: 20.0 ),
          CustomInputWidget(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            textController: paswdCtrl,
            isPassword: true,
          ),
          SizedBox( height: 36.0 ),
          ButtonWidget(
            title: 'Ingrese',
            onPressButton: !_provider.isLoging 
              ? () => _onTapLogin ( _provider, _socket )
              : null
          )
        ],
      ),
    );
  }
}