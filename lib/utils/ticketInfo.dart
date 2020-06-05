import 'package:flutter/material.dart';

class TicketInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin giá vé')
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 30),
            Container(
              child: Text('1. GIÁ VÉ PHIM 2D', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ), 
            SizedBox(height: 10),
            Container(
              child: Image.asset('assets/images/giave2d.png')
            ),
            SizedBox(height: 30),
            Container(
              child: Text('2. GIÁ VÉ PHIM 3D', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ), 
            SizedBox(height: 10),
            Container(
              child: Image.asset('assets/images/giave3d.png')
            ),
          ],)
      ),
    );
  }
}