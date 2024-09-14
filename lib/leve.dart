import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:workour_application/maingoal.dart';

class SelectLevelPage extends StatefulWidget {
  final String? token;

  const SelectLevelPage({Key? key, this.token}) : super(key: key);

  @override
  _SelectLevelPageState createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  String? selectedLevel;
  final int id = 2;

  Future<void> _submitLevel() async {
    if (selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a level')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/enterLevel'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': widget.token != null ? 'Bearer ${widget.token}' : '',
        },
        body: jsonEncode({
          'id': id,
          'Level': selectedLevel,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['errNum'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Level added successfully')),
          );
          Get.to(() => MainGoalPage(token: widget.token));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add level: ${data['msg']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add level: ${response.body}')),
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
            Text("Step 4/5"),
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
              "Select Your Level",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please select your level of experience.",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  LevelSelectionButton(
                    label: 'Advanced',
                    isSelected: selectedLevel == 'Advanced',
                    onTap: () => setState(() {
                      selectedLevel = 'Advanced';
                    }),
                  ),
                  LevelSelectionButton(
                    label: 'Average',
                    isSelected: selectedLevel == 'Average',
                    onTap: () => setState(() {
                      selectedLevel = 'Average';
                    }),
                  ),
                  LevelSelectionButton(
                    label: 'Beginner',
                    isSelected: selectedLevel == 'Beginner',
                    onTap: () => setState(() {
                      selectedLevel = 'Beginner';
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitLevel,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text(
                  'Submit Level',
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

class LevelSelectionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const LevelSelectionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 10),
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
