import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BusinessInfoPage extends StatelessWidget {
  final businessText = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Thông tin doanh nghiệp')
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 30),
        child:Column(
        children: <Widget>[
          AutoSizeText('RẠP CHIẾU PHIM QUỐC GIA NCC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[900]),),
          SizedBox(height: 20),
          AutoSizeText('Cơ quan chủ quản: BỘ VĂN HÓA, THỂ THAO VÀ DU LỊCH', style: businessText),
          AutoSizeText('Bản quyền thuộc Trung tâm Chiếu phim Quốc gia', style: businessText),
          AutoSizeText('Giấy phép số: 224/GP- TTĐT ngày 31/8/2010', style: businessText),
          AutoSizeText('Chịu trách nhiệm: Nguyễn Danh Dương – Giám đốc', style: businessText),
          AutoSizeText('Địa chỉ: 87 Láng Hạ, Quận Ba Đình, Tp. Hà Nội', style: businessText),
          AutoSizeText('Điện thoại: 024.35141791', style: businessText),
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