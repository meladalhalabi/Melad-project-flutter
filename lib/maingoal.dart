import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:workour_application/thepagemain.dart'; // تأكد من أن هذا هو المسار الصحيح لصفحة الـ Home

class MainGoalPage extends StatefulWidget {
  final String? token;

  const MainGoalPage({Key? key, this.token}) : super(key: key);

  @override
  _MainGoalPageState createState() => _MainGoalPageState();
}

class _MainGoalPageState extends State<MainGoalPage> {
  String? selectedMainGoal;

  Future<void> _submitMainGoal() async {
    if (selectedMainGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select your main goal')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/enterMainGoal'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': widget.token != null ? 'Bearer ${widget.token}' : '',
        },
        body: jsonEncode({'id': selectedMainGoal}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Main Goal submitted successfully')),
          );
          Get.to(() => HomePage(
                token: widget.token,
                goalId: selectedMainGoal,
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to submit Main Goal: ${response.body}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit Main Goal: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Step 5/5",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "What's Your Main Goal?",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Choose the goal that best describes you",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  MainGoalSelectionButton(
                    label: "Build the Body",
                    id: "1",
                    isSelected: selectedMainGoal == "1",
                    onTap: () => setState(() {
                      selectedMainGoal = "1";
                    }),
                  ),
                  MainGoalSelectionButton(
                    label: "Weight Loss",
                    id: "2",
                    isSelected: selectedMainGoal == "2",
                    onTap: () => setState(() {
                      selectedMainGoal = "2";
                    }),
                  ),
                  MainGoalSelectionButton(
                    label: "Save on the Body",
                    id: "3",
                    isSelected: selectedMainGoal == "3",
                    onTap: () => setState(() {
                      selectedMainGoal = "3";
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitMainGoal,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainGoalSelectionButton extends StatelessWidget {
  final String label;
  final String id;
  final bool isSelected;
  final VoidCallback onTap;

  const MainGoalSelectionButton({
    required this.label,
    required this.id,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.blueGrey : Colors.grey[300],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
