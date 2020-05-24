import 'package:flutter/material.dart';
import 'package:sbfood/screens/add_info_shop.dart';
import 'package:sbfood/utility/my_style.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  void routeToAddInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddInfoShop(),
      );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyStyle()
            .titleCenter(context, 'ยังไม่มีข้อมูล  กรุณาเพิ่มข้อมูลด้วยครับ.'),
        addAndEditButton()
      ],
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
              ),
              child: FloatingActionButton(
                backgroundColor: MyStyle().primaryColor,
                child: Icon(Icons.edit),
                onPressed: () => routeToAddInfo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
