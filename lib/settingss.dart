import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workour_application/controll/cll.dart';
import 'package:workour_application/controll/settings.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyLocaleCintrooler local = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Set'.tr),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sw'.tr),
                MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    local.Changelang("ar");
                  },
                  child: Text("Arabic"),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    local.Changelang("en");
                  },
                  child: Text("English"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
