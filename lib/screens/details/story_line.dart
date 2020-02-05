import 'package:flutter/material.dart';

class Storyline extends StatefulWidget {
  Storyline(this.storyline);
  final String storyline;

  @override
  _StorylineState createState() => _StorylineState();
}

class _StorylineState extends State<Storyline> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          'Giới thiệu',
          style:
              textTheme.subhead.copyWith(fontSize: 18.0, color: Colors.white),
        ),
        Text(
          widget.storyline,
          style: textTheme.body1.copyWith(
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: isCollapsed ? 3 : 999,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isCollapsed = !isCollapsed;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              !isCollapsed
                  ? Text(
                      "Thu gọn",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text("Xem thêm", style: TextStyle(color: Colors.red))
            ],
          ),
        ),
      ],
    );
  }
}
