import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  final String? token;

  LoginPage({required this.token});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pocketNumberController = TextEditingController();

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/paid'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
        'pocket_number': _pocketNumberController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainExercisesPage(
              token: widget.token!,
              exercises: data['Exercises_Paid'],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['msg'])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _pocketNumberController,
              decoration: InputDecoration(labelText: 'Pocket Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainExercisesPage extends StatelessWidget {
  final String token;
  final List<dynamic> exercises;

  MainExercisesPage({required this.token, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Exercises')),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.green.shade100, 
            child: ListTile(
              title: Text(
                exercise['exercise_area'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubExercisesPage(
                      token: token,
                      exerciseId: exercise['id'],
                      exerciseArea: exercise['exercise_area'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SubExercisesPage extends StatefulWidget {
  final String token;
  final int exerciseId;
  final String exerciseArea;

  SubExercisesPage({
    required this.token,
    required this.exerciseId,
    required this.exerciseArea,
  });

  @override
  _SubExercisesPageState createState() => _SubExercisesPageState();
}

class _SubExercisesPageState extends State<SubExercisesPage> {
  List<dynamic> _subExercises = [];

  @override
  void initState() {
    super.initState();
    _fetchSubExercises();
  }

  Future<void> _fetchSubExercises() async {
    String url;
    if (widget.exerciseArea == 'Weight loss') {
      url = 'http://10.0.2.2:8000/api/showWeightLoss';
    } else if (widget.exerciseArea == 'Warm-up') {
      url = 'http://10.0.2.2:8000/api/showWarmUp';
    } else {
      return;
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        if (widget.exerciseArea == 'Weight loss') {
          _subExercises = data['Weight_Loss_Exercises'];
        } else if (widget.exerciseArea == 'Warm-up') {
          _subExercises = data['Exercises_Paid'];
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load exercises')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sub Exercises')),
      body: ListView.builder(
        itemCount: _subExercises.length,
        itemBuilder: (context, index) {
          final exercise = _subExercises[index];
          return ListTile(
            title: Text(exercise['exercise_name']),
            subtitle: Text('Reps: ${exercise['exercise_number']}'),
          );
        },
      ),
    );
  }
}
