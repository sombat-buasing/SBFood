import 'package:flutter/material.dart';
import 'package:sbfood/screens/main_rider.dart';
import 'package:sbfood/screens/main_shop.dart';
import 'package:sbfood/screens/main_user.dart';
import 'package:sbfood/screens/signin.dart';
import 'package:sbfood/screens/signup.dart';
import 'package:sbfood/utility/my_style.dart';
import 'package:sbfood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('ChooseType');
      if (chooseType != null && chooseType.isNotEmpty) {
        print('$chooseType');
        if (chooseType == 'user') {
          routeToService(MainUser());
        } else if (chooseType == 'shop') {
          routeToService(MainShop());
        } else if (chooseType == 'rider') {
          routeToService(MainRider());
        } else {
          normalDialog(context, 'error');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('guest.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Guest'),
      accountEmail: Text('Please login.'),
    );
  }
}
