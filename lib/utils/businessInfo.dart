import 'package:flutter/material.dart';

class BusinessInfoPage extends StatelessWidget {
  final businessText = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin doanh nghiệp')
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 30),
        child:Column(
        children: <Widget>[
          Text('RẠP CHIẾU PHIM QUỐC GIA NCC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[900]),),
          SizedBox(height: 20),
          Text('Cơ quan chủ quản: BỘ VĂN HÓA, THỂ THAO VÀ DU LỊCH', style: businessText),
          Text('Bản quyền thuộc Trung tâm Chiếu phim Quốc gia', style: businessText),
          Text('Giấy phép số: 224/GP- TTĐT ngày 31/8/2010', style: businessText),
          Text('- Chịu trách nhiệm: Nguyễn Danh Dương – Giám đốc', style: businessText),
          Text('Địa chỉ: 87 Láng Hạ, Quận Ba Đình, Tp. Hà Nội - Điện thoại:', style: businessText),
          Text('024.35141791', style: businessText),
          SizedBox(height: 20),
          Container(
            height: 80,
            width: 150,
            child: Image.asset('assets/images/logo_da_thong_bao.png')
          )
        ]
      )
      ),
    );
  }
}