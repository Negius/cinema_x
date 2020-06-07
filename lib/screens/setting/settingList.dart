import 'package:cinema_x/screens/account/userInfo.dart';
import 'package:cinema_x/screens/account/task/accountDetails.dart';
import 'package:cinema_x/utils/businessInfo.dart';
import 'package:cinema_x/utils/securityPolicy.dart';
import 'package:cinema_x/utils/termsofUse.dart';
import 'package:cinema_x/utils/ticketInfo.dart';
import 'package:flutter/material.dart';

enum Languages {vietnamese, english}
class SettingList extends StatefulWidget {
  @override
  _SettingListState createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  Languages selectedLang = Languages.vietnamese;
  final height1 = 70.0;
  final height2 = 60.0;
  final titleStyle = TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold, fontSize: 15);
  final textPadding = EdgeInsets.only(left: 10);
  final iconPadding = EdgeInsets.only(right: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),),
        title: Text('Cài đặt'),
      ),
      body: Container(
        // color: Colors.amber[50],
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: <Widget>[
            // Container(
            //   height: height1,
            // ), 
            // Divider(thickness:1),
            Container(
              height: height2,
              child: ListTile(
                // focusColor: Colors.amber,
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountDetailsPage())),
                title: Text('Tài khoản'),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
            Divider(thickness:1),
            Container(
              height: height1,
              padding: EdgeInsets.only(top:25, left: 10),
              child: Text('NGÔN NGỮ', style: titleStyle,),
            ),Divider(thickness: 1),
            Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Tiếng Việt'),
                    trailing: Radio(
                      value: Languages.vietnamese, 
                      groupValue: selectedLang, 
                      onChanged: (value) {}),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text('Tiếng Anh'),
                    trailing: Radio(
                      value: Languages.english, 
                      groupValue: selectedLang, 
                      onChanged: (value) {}),
                  ),
                ]
              ),
            Divider(thickness: 1),
            Container(
              height: height1,
              padding: EdgeInsets.only(top:25, left: 10),
              child: Text('CÀI ĐẶT KHÁC', style: titleStyle,),
            ),Divider(thickness: 1),
            Container(
              height: height2,
              child: ListTile(
                title: Text('Điều khoản sử dụng'),
                trailing: Icon(Icons.arrow_right),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsofUsePage())),
              )
            ), Divider(thickness:1),
            Container(
              height: height2,
              child: ListTile(
                title: Text('Thông tin giá vé'),
                trailing: Icon(Icons.arrow_right),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketInfoPage())),
              )
            ), Divider(thickness:1),
            Container(
              height: height2,
              child: ListTile(
                title: Text('Chính sách bảo mật'),
                trailing: Icon(Icons.arrow_right),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> SecurityPolicyPage())),
              )
            ), Divider(thickness:1),
            Container(
              height: height2,
              child: ListTile(
                title: Text('Thông tin doanh nghiệp'),
                trailing: Icon(Icons.arrow_right),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> BusinessInfoPage())),
              )
            ),
            // Divider(thickness: 1),
            // Container(
            //   height: height1,
            // ),
          ]
        )
      ),
    );
  }
}