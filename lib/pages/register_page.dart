import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk/helpers/login_alert.dart';
import 'package:talk/services/auth_service.dart';

import 'package:talk/widgets/logo_widget.dart';
import 'package:talk/widgets/button_widget.dart';
import 'package:talk/widgets/politics_widget.dart';
import 'package:talk/widgets/custom_input_widget.dart';
import 'package:talk/widgets/account_label_widget.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {



    return Scaffold(
      backgroundColor: Color( 0xffF2F2F2 ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of( context ).size.height * .95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(),
                _Form(),
                AccountLabelWidget(
                  actionTitle: '¿Ya tienes cuenta?',
                  action: 'ingresar ahora!',
                  route: 'login',
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
  TextEditingController nameCtrl  = TextEditingController();

  void _onTapRegister( AuthService authService ) async {

      bool status = await authService.register(
        name: nameCtrl.text.trim(), 
        email: emailCtrl.text.trim(), 
        password: paswdCtrl.text.trim(),
      );

      if ( status ) {
        Navigator.pushReplacementNamed( context, 'users' );
      } else {
        showLoginAlert( 
          context: context, 
          title: 'Registro incorrecto', 
          content: 'El correo ya se encuentra registrado.'
        );
      }
  }

  @override
  Widget build( BuildContext context ) {

    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: const EdgeInsets.only( top: 20.0 ),
      padding: const EdgeInsets.symmetric( horizontal: 50.0 ),
      child: Column(
        children: [
          CustomInputWidget( 
            icon: Icons.person_outline,
            placeholder: "Nombre",
            textController: nameCtrl,
            keyboardType: TextInputType.text,
          ),
          SizedBox( height: 20.0 ),
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
            title: 'Crear',
            onPressButton: !authService.isLoging
            ? () => _onTapRegister( authService )
            : null
          )
        ],
      ),
    );
  }
}