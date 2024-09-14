import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:workour_application/controll/cll.dart';

class MyLocaleCintrooler extends GetxController {
  void Changelang(String lang) {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
  }
}
