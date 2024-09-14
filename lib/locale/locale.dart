import 'package:workour_application/controll/cll.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "set": "الاعدادات",
          "sw": "تغيير اللغة",
          "h": "الصفحة الرئيسية",
          "ex": "التمارين ",
          "exp": "التمارين المدفوعة",
          "f": "نظام عذائي",
          "r": " التقرير"
        },
        "en": {
          "set": "Settings",
          "sw": "switch Language",
          "h": "Home Page",
          "ex": "ُExcercices",
          "exp": "Paid Excercices",
          "f": "food",
          "r": "Reporter"
        }
      };
}
