import 'dart:async';

mixin Validator{
  var emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      if(email.contains("@"))
      {
        sink.add(email);
      }
      else
      {
        sink.addError("Email không đúng định dạng");
      }

    }
  );
   var passwordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length > 6)
      {
        sink.add(password);
      }
      else
      {
        sink.addError("Mật khẩu phải lớn hơn 6 ký tự");
      }

    }
  );

}