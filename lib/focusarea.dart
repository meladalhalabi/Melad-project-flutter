import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:workour_application/leve.dart';

class FocusAreaPage extends StatefulWidget {
  final String? token;
  const FocusAreaPage({Key? key, this.token}) : super(key: key);

  @override
  _FocusAreaPageState createState() => _FocusAreaPageState();
}

class _FocusAreaPageState extends State<FocusAreaPage> {
  String? selectedFocusArea;

  Future<void> _submitFocusArea() async {
    if (selectedFocusArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select your focus area')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/enterFocusArea'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': widget.token != null ? 'Bearer ${widget.token}' : '',
        },
        body: jsonEncode({'id': selectedFocusArea}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Focus Area submitted successfully')),
          );
          Get.to(() => SelectLevelPage(token: widget.token));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to submit Focus Area: ${response.body}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit Focus Area: ${response.body}')),
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
            Text("Step 3/5"),
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
              "What's Your Focus Area?",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Choose the area you want to focus on",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  FocusAreaSelectionButton(
                    label: "All Body",
                    id: "1",
                    isSelected: selectedFocusArea == "1",
                    onTap: () => setState(() {
                      selectedFocusArea = "1";
                    }),
                  ),
                  FocusAreaSelectionButton(
                    label: "Chest",
                    id: "2",
                    isSelected: selectedFocusArea == "2",
                    onTap: () => setState(() {
                      selectedFocusArea = "2";
                    }),
                  ),
                  FocusAreaSelectionButton(
                    label: "Arms",
                    id: "3",
                    isSelected: selectedFocusArea == "3",
                    onTap: () => setState(() {
                      selectedFocusArea = "3";
                    }),
                  ),
                  FocusAreaSelectionButton(
                    label: "Belly",
                    id: "4",
                    isSelected: selectedFocusArea == "4",
                    onTap: () => setState(() {
                      selectedFocusArea = "4";
                    }),
                  ),
                  FocusAreaSelectionButton(
                    label: "Feet",
                    id: "5",
                    isSelected: selectedFocusArea == "5",
                    onTap: () => setState(() {
                      selectedFocusArea = "5";
                    }),
                  ),
                  FocusAreaSelectionButton(
                    label: "Noon",
                    id: "6",
                    isSelected: selectedFocusArea == "6",
                    onTap: () => setState(() {
                      selectedFocusArea = "6";
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitFocusArea,
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

class FocusAreaSelectionButton extends StatelessWidget {
  final String label;
  final String id;
  final bool isSelected;
  final VoidCallback onTap;

  const FocusAreaSelectionButton({
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
