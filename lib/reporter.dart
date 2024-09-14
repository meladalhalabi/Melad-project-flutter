import 'package:flutter/material.dart';
import 'controll/cll.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerA controller = Get.put(ControllerA());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Report",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Obx(() => ReportCard("Calories Burned",
                controller.calories.value.toString(), "Kcal")),
            const SizedBox(height: 20),
            Obx(() => ReportCard("Current Weight",
                controller.currentWeight.value.toString(), "Kg")),
            const SizedBox(height: 20),
            Obx(() => ReportCard("Exercise Time",
                controller.minutes.value.toString(), "Minutes")),
            const SizedBox(height: 20),
            Obx(() => ReportCard("Total Workouts",
                controller.exercises.value.toString(), "Workouts")),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget ReportCard(String title, String value, String unit) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            Text(
              unit,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
