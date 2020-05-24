import 'package:flutter/material.dart';
import 'package:sbfood/screens/home.dart';
import 'package:sbfood/utility/my_style.dart';
import 'package:sbfood/widget/information_shop.dart';
import 'package:sbfood/widget/list_food_menu_shop.dart';
import 'package:sbfood/widget/order_list_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(),
          )
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Future<Null> signOutProcess() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // exit(0);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Home(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            foodMenu(),
            informationMenu(),
            signOut(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหารที่ลูกค้าสั่ง'),
        subtitle: Text('รายการอาหารที่ยังไม่ได้ทำส่งลูกค้า'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการอาหารตามเมนูของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile informationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียดของร้าน'),
        subtitle: Text('รายละเอียด ของร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget = InformationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOut() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out และกลับไปหน้าแรก'),
        onTap: () => signOutProcess(),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name'),
      accountEmail: Text('Login'),
    );
  }
}
