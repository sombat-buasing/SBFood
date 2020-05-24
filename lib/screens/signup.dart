import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sbfood/utility/my_style.dart';
import 'package:sbfood/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          myLogo(),
          MyStyle().mySizeBox(),
          showAppName(),
          MyStyle().mySizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          userForm(),
          MyStyle().mySizeBox(),
          passwordForm(),
          MyStyle().mySizeBox(),
          MyStyle().showTitleH2('ชนิดของผู้สมัคร'),
          MyStyle().mySizeBox(),
          userRadio(),
          shopRadio(),
          riderRadio(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          print(
              'name = $name, user = $user, password = $password, chooseType = $chooseType');
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            print('have space');
            normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่อง ค่ะ');
          } else if (chooseType == null) {
            normalDialog(context, 'โปรดเลือกชนิดของผู้สมัคร');
          } else {
            checkUser();
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> registerThread() async {
    String url = 'http://192.168.56.1/sbfood/addUser.php?isAdd=true&Name=$name&User=$user&ChooseType=$chooseType&Password=$password';
    
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่ ครับ');
      }
    } catch (e){
      print(e);
    }
  }
  

  Future<Null> checkUser() async {
    String url = 'http://192.168.56.1/sbfood/getUserWhereUser.php?isAdd=true&User=$user';
    
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(context, 'User นี้ มีอยู่ระบบแล้ว กรุณาลองใหม่ ครับ');
      }
    } catch (e){
      print(e);
    }
    
  }

  Widget userRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: 'user',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'ผู้สั่งอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shopRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: 'shop',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'เจ้าของร้านอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget riderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: 'rider',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'ผู้ส่งอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'User :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Password :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTitle('SB Food'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo(),
        ],
      );
}
