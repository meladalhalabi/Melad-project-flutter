import 'package:get/get.dart';

export 'package:get/get.dart';

class ControllerA extends GetxController {
  var state = false.obs;
  var state1 = false.obs;
  var Visible = false.obs;

  var a = false.obs;
  var b = false.obs;
  var c = false.obs;
  var d = false.obs;
  var e = false.obs;
  RxBool fullBody = false.obs;
  RxBool arm = false.obs;
  RxBool abs = false.obs;
  RxBool butt = false.obs;
  RxBool leg = false.obs;

  RxBool state2 = false.obs;
  var weight = 60.0.obs; 
  var height = 170.0.obs;

  void setWeight(double value) => weight.value = value;
  void setHeight(double value) => height.value = value;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  void setFirstName(String value) => firstName.value = value;
  void setLastName(String value) => lastName.value = value;
  void setUsername(String value) => username.value = value;
  void setPassword(String value) => password.value = value;
  void setConfirmPassword(String value) => confirmPassword.value = value;

  RxInt calories = 0.obs;
  RxInt minutes = 0.obs;
  RxInt exercises = 0.obs;


  RxBool fullBodySelected = false.obs;
  RxBool armSelected = false.obs;
  RxBool absSelected = false.obs;
  RxBool buttSelected = false.obs;
  RxBool legSelected = false.obs;
  RxInt currentWeight = 40.obs;


  void updateCalories(int value) {
    calories.value -= value;
  }

  // دالة لتحديث الوقت عند إكمال تمرين
  void updateMinutes(int value) {
    minutes.value += value;
  }

  // دالة لتحديث عدد التمارين
  void incrementExercises() {
    exercises.value += 1;
  }


  void updateState2() {
    state2.value =
        fullBody.value || arm.value || abs.value || butt.value || leg.value;
  }
}
