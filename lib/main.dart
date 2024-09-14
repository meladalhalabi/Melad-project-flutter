import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workour_application/SplashScreen.dart';
import 'package:workour_application/controll/settings.dart';
import 'package:workour_application/locale/locale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleCintrooler());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      translations: MyLocale(),
      home: SplashScreen(),
    );
  }
}
