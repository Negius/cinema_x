import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SecurityPolicyPage extends StatelessWidget {
  final _titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  final _policyStyle = TextStyle(fontSize: 15, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Chính sách bảo mật')
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 30),
          child: Column(
            children: [
              AutoSizeText('CHÍNH SÁCH BẢO MẬT THÔNG TIN CÁ NHÂN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange[900]),),
              AutoSizeText('KHÁCH HÀNG', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange[900])),
              SizedBox(height: 30),
              AutoSizeText('Mục đích và phạm vi thu thập thông tin', style: _titleStyle),
              AutoSizeText('1.1 Việc thu thập thông tin cá nhân được thực hiện trên cơ sở khách hàng tự khai báo để đăng ký thành viên NCC tại website https://chieuphimquocgia.com.vn/, tùy từng thời điểm, thông tin thu thập sẽ bao gồm nhưng không giới hạn ở:', style: _policyStyle),
              AutoSizeText(' - Thông tin cá nhân như: họ tên, giới tính, độ tuổi, số CMND', style: _policyStyle),
              AutoSizeText(' - Thông tin liên lạc như: địa chỉ, số điện thoại di động, email/fax', style: _policyStyle),
              AutoSizeText(' - Các thông tin khác phục vụ cho chương trình khách hàng thân thiết (nếu có)', style: _policyStyle),
              AutoSizeText('1.2 Mục đích thu thập thông tin khách hàng bao gồm:', style: _policyStyle),
              AutoSizeText(' - Cung cấp các dịch vụ, sản phẩm theo nhu cầu của khách hàng', style: _policyStyle),
              AutoSizeText(' - Liên hệ xác nhận khi khách hàng đăng ký sử dụng dịch vụ, xác lập giao dịch trên website https://chieuphimquocgia.com.vn/', style: _policyStyle),
              AutoSizeText(' - Thực hiện việc quản lý website https://chieuphimquocgia.com.vn/, gửi thông tin cập nhật về website, các chương trình khuyến mại, ưu đãi/tri ân tới khách hàng', style: _policyStyle),
              AutoSizeText(' - Bảo đảm quyền lợi của khách hàng khi phát hiện các hành động giả mạo, phá hoại tài khoản, lừa đảo khách hàng', style: _policyStyle),
              AutoSizeText(' - Liên lạc, hỗ trợ, giải quyết với khách hàng trong các trường hợp đặc biệt', style: _policyStyle),
              AutoSizeText('1.3 Để tránh nghi ngờ, trong quá trình giao dịch thanh toán tại website https://chieuphimquocgia.com.vn/, NCC chỉ lưu giữ thông tin chi tiết về đơn hàng đã thanh toán của khách hàng, các thông tin về tài khoản ngân hàng của khách hàng sẽ không được lưu giữ.', style: _policyStyle),
              SizedBox(height: 10),
              AutoSizeText('Phạm vi sử dụng thông tin', style: _titleStyle),
              AutoSizeText('2.1 NCC chỉ sử dụng thông tin cá nhân của khách hàng cho các mục đích quy định tại Mục 1 hoặc mục đích khác (nếu có) với điều kiện đã thông báo và được sự đồng ý của khách hàng.', style: _policyStyle),
              AutoSizeText('2.2 NCC sẽ không sử dụng thông tin cá nhân của khách hàng để gửi quảng cáo, giới thiệu dịch vụ và các thông tin có tính thương mại khác khi chưa được khách hàng chấp thuận.', style: _policyStyle),
              AutoSizeText('2.3 Khách hàng hiểu và đồng ý rằng NCC có nghĩa vụ phải cung cấp thông tin khách hàng theo yêu cầu/quyết định của Cơ quan nhà nước có thẩm quyền và/hoặc quy định pháp luật. NCC sẽ được miễn trừ mọi trách nhiệm liên quan đến bảo mật thông tin trong trường hợp này.', style: _policyStyle),
              SizedBox(height: 10),
              AutoSizeText('Thời gian lưu trữ thông tin', style: _titleStyle),
              AutoSizeText('Dữ liệu cá nhân cơ bản của khách hàng đăng ký thành viên NCC sẽ được lưu trữ cho đến khi có yêu cầu hủy bỏ hoặc tự thành viên đăng nhập và thực hiện đóng tài khoản. Đối với các tài khoản đã đóng chúng tôi vẫn lưu trữ thông tin cá nhân và truy cập của khách hàng để phục vụ cho mục đích phòng chống gian lận, điều tra, giải đáp thắc mắc ... Các thông tin này sẽ được lưu trữ trong hệ thống máy chủ tối đa mười hai (12) tháng. Hết thời hạn này, NCC sẽ tiến hành xóa vĩnh viễn thông tin cá nhân của khách hàng.', style: _policyStyle),
              SizedBox(height: 10),
              AutoSizeText('Cách thức chỉnh sửa dữ liệu cá nhân', style: _titleStyle),
              AutoSizeText('Để chỉnh sửa dữ liệu cá nhân của mình trên hệ thống thương mại điện tử của NCC, khách hàng có thể tự đăng nhập và chỉnh sửa thông tin, dữ liệu cá nhân, ngoại trừ các thông tin về Họ tên, Giới tính, Ngày sinh và Chứng minh nhân dân.', style: _policyStyle),
              SizedBox(height: 10),
              AutoSizeText('NCC cam kết', style: _titleStyle),
              AutoSizeText('5.1 Mọi thông tin cá nhân của khách hàng thu thập được từ website https://chieuphimquocgia.com.vn/ sẽ được lưu giữ an toàn; chỉ có khách hàng mới có thể truy cập vào tài khoản cá nhân của mình bằng tên đăng nhập và mật khẩu do khách hàng chọn.', style: _policyStyle),
              AutoSizeText('5.2 NCC cam kết bảo mật thông tin, không chia sẻ, tiết lộ, chuyển giao thông tin cá nhân của khách hàng, thông tin giao dịch trực tuyến trên website https://chieuphimquocgia.com.vn/ cho bất kỳ bên thứ ba nào khi chưa được sự đồng ý của khách hàng, trừ trường hợp phải thực hiện theo yêu cầu của các cơ quan Nhà nước có thẩm quyền, hoặc theo quy định của pháp luật hoặc việc cung cấp thông tin đó là cần thiết để NCC cung cấp dịch vụ/ tiện ích cho khách hàng.', style: _policyStyle),
              AutoSizeText('5.3 NCC, bằng nỗ lực tốt nhất của mình, sẽ áp dụng các giải pháp công nghệ để ngăn chặn các hành vi đánh cắp hoặc tiếp cận thông tin trái phép; sử dụng, thay đổi hoặc phá hủy thông tin trái phép. Tuy nhiên, NCC không thể cam kết sẽ ngăn chặn được tất cả các hành vi xâm phạm, sử dụng thông tin cá nhân trái phép nằm ngoài khả năng kiểm soát của NCC. NCC sẽ không chịu trách nhiệm dưới bất kỳ hình thức nào đối với bất kỳ khiếu nại, tranh chấp hoặc thiệt hại nào phát sinh từ hoặc liên quan đến việc truy cập, xâm nhập, sử dụng thông tin trái phép như vậy.', style: _policyStyle),
              AutoSizeText('5.4 Trường hợp máy chủ lưu trữ thông tin bị hacker tấn công dẫn đến mất mát dữ liệu cá nhân, gây ảnh hưởng xấu đến khách hàng, NCC sẽ ngay lập tức thông báo cho khách hàng và trình vụ việc cho cơ quan chức năng điều tra xử lý.', style: _policyStyle),
              AutoSizeText('5.5 Đối với các giao dịch trực tuyến được thực hiện thông qua website https://chieuphimquocgia.com.vn/, NCC không lưu trữ thông tin thẻ thanh toán của khách hàng. Thông tin tài khoản, thẻ thanh toán của khách hàng sẽ được các đối tác cổng thanh toán của NCC bảo vệ theo tiêu chuẩn quốc tế.', style: _policyStyle),
              AutoSizeText('5.6 Khách hàng có nghĩa vụ bảo mật tên đăng ký, mật khẩu và hộp thư điện tử của mình. NCC sẽ không chịu trách nhiệm dưới bất kỳ hình thức nào đối với các thiệt hại, tổn thất (nếu có) do khách hàng không tuân thủ quy định bảo mật này.', style: _policyStyle),
              AutoSizeText('5.7 Khách hàng tuyệt đối không được có các hành vi sử dụng công cụ, chương trình để can thiệp trái phép vào hệ thống hay làm thay dổi dữ liệu của NCC. Trong trường hợp NCC phát hiện khách hàng có hành vi cố tình giả mạo, gian lận, phát tán thông tin cá nhân trái phép … NCC có quyền chuyển thông tin cá nhân của khách hàng cho các cơ quan có thẩm quyền để xử lý theo quy định của pháp luật.', style: _policyStyle),
              SizedBox(height: 20),
            ],)
        ),
      ),
    );
  }
}