class ErrorId {
  static const String isEmpty = "Tên đăng nhập không được để trống";
  static const String wrongLength =
      "Tên đăng nhập phải có độ dài từ 6-15 ký tự";
  static const String specialChar =
      "Tên đăng nhập chỉ được chứa ký tự chữ cái, số và dấu gạch chân (_)";
  static const String notExisted = "Tài khoản không tồn tại!";
}

class ErrorEmail {
  static const String isEmpty = "Email không được để trống";
  static const String wrongFormat = "Email không đúng định dạng";
}

class RegexPassword {
  RegExp digit = new RegExp(r"(?=.*\d)");
  RegExp lower = new RegExp(r"(?=.*[a-z])");
  RegExp upper = new RegExp(r"(?=.*[A-Z])");
  RegExp special = new RegExp(r"(?=.*[!@#$%^&*(),.?:{}|<>])");
  RegExp base = new RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?:{}|<>])");
}

class ErrorPassword {
  static const String isEmpty = "Mật khẩu không được để trống";
  static const String digit = "Mật khẩu phải chứa ít nhất 1 chữ số";
  static const String lower = "Mật khẩu phải chứa ít nhất 1 ký tự viết thường";
  static const String upper = "Mật khẩu phải chứa ít nhất 1 ký tự viết hoa";
  static const String special =
      "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt";
  static const String length = "Mật khẩu phải có độ dài ít nhất 8 ký tự";
  static const String wrongPassword = "Mật khẩu không chính xác!";
  static const String wrongPassword2 = "Hãy nhập lại chính xác mật khẩu";
  static const String wrongPassword3 = "Mật khẩu nhập lại không trùng khớp";
}

class ErrorPhone{
  static const String invalidPhone = "Số điện thoại không hợp lệ";
}