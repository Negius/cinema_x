class AppSettings {
  static const String vnpayHashSecret = "IPCYRCERGNCBFGRYXUBYSWTDCEPHWGUZ";

  static const String vnpayTmnCode = "DXUMNOYW";

  static const String checksumPayoo = "2973880262d35aeff161c1401163e68d";
}

class NccUrl {
  //fetch data
  static const String getSeat =
      "http://testapi.chieuphimquocgia.com.vn/api/GetSeats?PlanId=";

  static const String getFilms =
      "http://testapi.chieuphimquocgia.com.vn/api/GetFilms";

  static const String getFilmShowing =
      "http://testapi.chieuphimquocgia.com.vn/api/FilmShowings";

  static const String getNews =
      "http://testapi.chieuphimquocgia.com.vn/api/News";

  static const String getAllNews =
      "http://testapi.chieuphimquocgia.com.vn/api/AllNews";

  static const String getSchedules =
      "http://testapi.chieuphimquocgia.com.vn/api/GetAllSession";

  static const String getSessions =
      "http://testapi.chieuphimquocgia.com.vn/api/GetAllSessionbyFilm?Filmid=";

  //app actions
  static const String buildPhoto =
      "https://chieuphimquocgia.com.vn/Content/Images/";

  static const String createOrder =
      "http://testapi.chieuphimquocgia.com.vn/api/CreateOrder";

  static const String updateOrder =
      "http://testapi.chieuphimquocgia.com.vn/api/UpdateOrderPaymentApp?";

  //user actions
  static const String updateCustomer =
      "http://testapi.chieuphimquocgia.com.vn/api/UpdateCustomer?";

  static const String changePassword =
      "http://testapi.chieuphimquocgia.com.vn/api/ChangePassword?";

  static const String login =
      "http://testapi.chieuphimquocgia.com.vn/api/LoginApp?";

  static const String registerAccount =
      "http://testapi.chieuphimquocgia.com.vn/api/Register";

  static const String createComment =
      "http://testapi.chieuphimquocgia.com.vn/api/CreateFilmComment";
}

class PaymentUrl {
  static const String vnpayInit =
      "http://sandbox.vnpayment.vn/paymentv2/vpcpay.html?";

  static const String vnpayResult = "http://172.16.80.120/CheckOut/VNPayResult";

  static const String payooInit =
      "https://newsandbox.payoo.com.vn/v2/paynow/order/create";

  static const String payooResult =
      "http://localhost:3813/CheckOut/PayooResult";
}

class CommonString {
  static const String homePage = "Trang chủ";
  static const String ok = "Xác nhận";
  static const String cancel = "Hủy bỏ";
  static const String back = "Quay lại";
  static const String exit = "Thoát";
  static const String all = "Tất cả";
  static const String commonError = "Đã có lỗi xảy ra";
  static const String accountInfo = "THÔNG TIN TÀI KHOẢN";
  static const String additionalInfo = "THÔNG TIN THÊM";
  static const String contact = "LIÊN HỆ";
  static const String showing = "ĐANG CHIẾU";
  static const String coming = "SẮP CHIẾU";
  static const String special = "ĐẶC BIỆT";
  static const String news = "TIN TỨC";
  static const String news2 = "Tin tức và ưu đãi";

  static const String memberCard = "Thẻ thành viên";
  static const String member = "Thành viên";
  static const String cardInfo = "Thông tin thẻ thành viên";
  static const String cardOwner = "Tên chủ thẻ: ";
  static const String cardCode = "Mã thẻ: ";
  static const String cardLevel = "Hạng thẻ: ";
  static const String cardPoint = "Điểm thẻ: ";
  static const String rewardPoint = "Điểm thưởng";

  static const String detailedInfo = "Thông tin chi tiết";
  static const String gender = "Giới tính";
  static const String male = "Nam";
  static const String female = "Nữ";
  static const String saveInfo = "Lưu thông tin";

  static const String login = "Đăng nhập";
  static const String emailID = "Email hoặc tên đăng nhập";
  static const String password = "Mật khẩu";
  static const String showpassF = "Ẩn";
  static const String showpassT = "Hiện";
  static const String forgotPass = "Quên mật khẩu?";

  static const String register = "Đăng ký tài khoản";
  static const String register2 = "Đăng ký";
  static const String id = "Tên đăng nhập";
  static const String email = "Email";
  static const String rePassword = "Nhập lại mật khẩu";
  static const String firstName = "Tên";
  static const String lastName = "Họ";
  static const String birthday = "Ngày sinh";
  static const String phone = "Điện thoại";
  static const String address = "Địa chỉ";

  static const String changePassword = "Thay đổi mật khẩu";
  static const String currentPassword = "Mật khẩu hiện tại";
  static const String newPassword = "Mật khẩu mới";
  static const String newPassword2 = "Nhập lại mật khẩu mới";
  static const String changePasswordSuccess = "Thay đổi mật khẩu thành công";

  static const String purchaseHistory = "Lịch sử giao dịch";
  static const String watchedMovies = "Phim đã xem";

  static const String booking = "ĐẶT VÉ";
  static const String booking2 = "Đặt vé theo phim";
  static const String schedule = "Lịch chiếu phim";
  static const String chooseMovie = "Chọn phim";
  static const String chooseSession = "Chọn ca chiếu: ";
  static const String projectDate = "Ngày chiếu";
  static const String projectTime = "Thời gian chiếu";
  static const String seat = "Ghế";
  static const String screen = "MÀN HÌNH";
  static const String selectSeat = "Chọn vị trí ngồi";
  static const String seatNoEmptySpace =
      "Không được có khoảng trống giữa các ghế đã chọn";
  static const String seatAmount = "Số lượng";
  static const String seatLabel = "Vị trí ghế";
  static const String seatNormal = "Ghế thường";
  static const String seatVip = "Ghế VIP";
  static const String seatCouple = "Ghế đôi";
  static const String seatBought = "Ghế đã mua";
  static const String seatSelecting = "Ghế đang chọn";
  static const String seatSelectedAmount = "Số ghế đã chọn";
  static const String seatSelected = "Danh sách ghế";
  static const String total = "Tổng cộng ";
  static const String ticketInfo = "Thông tin vé";

  static const String actor = "Diễn viên";
  static const String duration = "Thời lượng: _TL_ phút";
  static const String image = "Ảnh";
  static const String introduction = "Giới thiệu";
  static const String trailerMore = "Xem thêm";
  static const String trailerLess = "Thu gọn";
  static const String movieInfo = """
Thể loại: _TL_

Đạo diễn: _DD_

Diễn viên: _DV_
""";
  static const String choosePayment = "Chọn phương thức thanh toán";
  static const String paymentNameVnpay = "VNPAY - Cổng thanh toán điện tử";
  static const String paymentNamePayoo = "Thanh toán online qua Payoo";
  static const String checkout = "Thanh toán";
  static const String accept1 =
      "Tôi đồng ý với Điều khoản Sử dụng và đang mua vé cho người có độ tuổi thích hợp";
  static const String accept2 = "Tôi đồng ý và tiếp tục";
  static const String rating = "Đánh giá phim";
  static const String comment = "Nhận xét phim";
}
