class ErrorId {
  static const String isEmpty = "Tên đăng nhập không được để trống";
  static const String wrongLength =
      "Tên đăng nhập phải có độ dài từ 6-15 ký tự";
  static const String specialChar =
      "Tên đăng nhập chỉ được chứa ký tự chữ cái, số và dấu gạch chân (_)";
}

class ErrorEmail {
  static const String isEmpty = "Email không được để trống";
  static const String wrongFormat = "Email không hợp lệ";
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
}
