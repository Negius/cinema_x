import 'dart:async';

import 'package:cinema_x/config/ValidateError.dart';

mixin Validator{
  var emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      if(email.contains("@"))
      {
        sink.add(email);
      }
      else
      {
        sink.addError(ErrorEmail.wrongFormat);
      }

    }
  );
   var passwordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length > 8)
      {
        sink.add(password);
      }
      else
      {
        sink.addError(ErrorPassword.length);
      }

    }
  );

}