import 'dart:convert';

import 'package:talk/models/user.dart';

LoginResponse loginResponseFromJson( String str ) => LoginResponse.fromJson( json.decode( str ));
String loginResponseToJson( LoginResponse data )  => json.encode( data.toJson() );

class LoginResponse {

    LoginResponse({ this.ok, this.user, this.token, this.message });

    bool ok;
    User user;
    String token;
    String message;


    factory LoginResponse.fromJson( Map<String, dynamic> json ) => LoginResponse(
        ok     : json["ok"],
        user   : User.fromJson(json["user"]),
        token  : json["token"],
        message: json["message"],
    );


    Map<String, dynamic> toJson() => {
        "ok"     : ok,
        "user"   : user.toJson(),
        "token"  : token,
        "message": message,
    };
}

