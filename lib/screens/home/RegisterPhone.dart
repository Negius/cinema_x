import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class RegisterPhonePage extends StatefulWidget {
  @override
  _RegisterPhonePageState createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  bool isSwitched;
  bool _isHover;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate;
  String _phoneNum;
  String _password;
  String _retype;

  @override
  void initState() {
    super.initState();
    isSwitched = true;
    _isHover = false;
    _autoValidate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            padding: EdgeInsets.all(10),
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _phoneNum = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) => validateForm("phone", value),
                      decoration: InputDecoration(
                        labelText: "aaa",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (value) => validateForm("pass", value),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "aaa",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _retype = value;
                        });
                      },
                      validator: (value) => validateForm("repass", value),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "aaa",
                        labelStyle:
                            TextStyle(color: Colors.black26, fontSize: 15),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).copyWith().size.height / 4,
              width: MediaQuery.of(context).copyWith().size.width -20,
              child: Center(
                child: InkWell(
                  child: Text(
                    "123456",
                    style: TextStyle(
                      color: _isHover ? Colors.lightBlue : Colors.blue,
                    ),
                  ),
                  onHover: (value) {
                    setState(() {
                      _isHover = value; //Đổi màu khi hover qua
                    });
                  },
                  // onTap: () => launch(''), //Hàm xử lý khi tap vào link
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String validateForm(String type, String value) {
    bool result = true;

    switch (type) {
      case "phone":
        break;
      case "pass":
        break;
      case "retype":
        break;
      default:
        break;
    }
    return result ? null : "Error";
  }
}
