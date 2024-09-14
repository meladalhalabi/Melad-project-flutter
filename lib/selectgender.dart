import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:workour_application/weightandheight.dart';

class SelectGender extends StatefulWidget {
  final String? token;

  const SelectGender({Key? key, this.token}) : super(key: key);

  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String? selectedGender;

  Future<void> _submitGender() async {
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select your gender')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/enterGender'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': widget.token != null ? 'Bearer ${widget.token}' : '',
        },
        body: jsonEncode({'gender': selectedGender}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gender submitted successfully')),
        );
        Get.to(() => EnterWeightHeightPage(token: widget.token));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit gender: ${response.body}')),
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
            Text("Step 1/5"),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        height: 1000,
        color: Colors.white,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "What's Your Gender?",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                "Let us know you better",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                width: double.infinity,
                height: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = "M";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectedGender == "M"
                                ? Colors.blueGrey
                                : Colors.grey[300],
                          ),
                          child: Image.asset(
                            selectedGender == "M"
                                ? "images/male.png"
                                : "images/1.png",
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = "F";
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectedGender == "F"
                                ? Colors.blueGrey
                                : Colors.grey[300],
                          ),
                          child: Image.asset(
                            selectedGender == "F"
                                ? "images/female.png"
                                : "images/2.png",
                            fit: BoxFit.cover,
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "M";
                        });
                      },
                      child: Center(
                        child: Text(
                          "Male",
                          style: TextStyle(
                            color: selectedGender == "M"
                                ? Colors.blueGrey
                                : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "F";
                        });
                      },
                      child: Center(
                        child: Text(
                          "Female",
                          style: TextStyle(
                            color: selectedGender == "F"
                                ? Colors.blueGrey
                                : Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              Row(
                children: [
                  Container(
                    width: 410,
                    child: MaterialButton(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.blueGrey,
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onPressed: _submitGender,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
