import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:talk/global/environment.dart';
import 'package:talk/models/login_response.dart';
import 'package:talk/models/user.dart';


class AuthService with ChangeNotifier {

  User _user;
  bool _isLoging = false;
  final _storage = new FlutterSecureStorage();

  bool get isLoging => this._isLoging;

  User get user => this._user;
  
  void _setIsLoging( bool value ) {
    this._isLoging = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read( key: 'jwtoken' );
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.delete( key: 'jwtoken' );
  }

  Future<bool> login({ @required email, @required password }) async {

    _setIsLoging( true );

    final data = {
      'email' : email,
      'password' : password
    };

    final headers = {
      'Content-Type': 'application/json'
    };

    try {
    
      final response = await http.post("${Environment.apiUrl}/login/", 
        body: jsonEncode( data ) , 
        headers: headers 
      );
      
      if ( response.statusCode == 200 ) {
        
        final loginResponse = loginResponseFromJson( response.body );
        this._user = loginResponse.user;
        
        await this._saveToken( loginResponse.token );
        _setIsLoging( false );
        
        return true;
      
      } else {
        
        _setIsLoging( false );
        return false;

      }

    } catch ( exception ) {
      print( exception );
      return false;
    }
  }

  Future<void> _saveToken( String token ) async => await _storage.write( key: 'jwtoken', value: token );
  
  //Future<void> _deleteToken() async => await _storage.delete( key: 'jwtoken' );

  Future<bool> register({ @required name, @required email, @required password }) async {
    
    _setIsLoging( true );
    
    final data = {
      'name': name,
      'email' : email,
      'password' : password
    };
    
    final headers = {
      'Content-Type': 'application/json'
    };

    try {

      final response = await http.post("${Environment.apiUrl}/login/new", 
        body: jsonEncode( data ) , 
        headers: headers 
      );

      if ( response.statusCode == 200 ) {
       
        print( response.body );
        final loginResponse = loginResponseFromJson( response.body );
        this._user = loginResponse.user;
        
        await this._saveToken( loginResponse.token );
        return true;
      
      } else {

        print( response.body );
        _setIsLoging( false );
        return false;
      }

    } catch ( exception ) {
      print( exception );
      return false;
    }
  }

  Future<bool> isLoggedIn() async {

    try {

      String token = await _storage.read( key: 'jwtoken' );
      
      if ( token == null ) {
        return false;
      }

      final headers = {
        'Content-Type': 'application/json',
        'x-token': token
      };

      try {

        final response = await http.get("${Environment.apiUrl}/login/renewToken",
          headers: headers 
        );
      
        print( response.body );

        if ( response.statusCode == 200 ) {
        
          final loginResponse = loginResponseFromJson( response.body );
          this._user = loginResponse.user;

          await this._saveToken( loginResponse.token );
          return true;

        } else {

          deleteToken();
          return false;
        }
      
      } catch ( exception ) {
      
        print( exception );
        return false;
      }

    } catch ( exception ) {
      return false;
    }
  }
}