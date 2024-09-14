import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WarmUpPage extends StatefulWidget {
  final String token;

  const WarmUpPage({Key? key, required this.token}) : super(key: key);

  @override
  _WarmUpPageState createState() => _WarmUpPageState();
}

class _WarmUpPageState extends State<WarmUpPage> {
  late Future<List<dynamic>> _futureWarmUp;

  @override
  void initState() {
    super.initState();
    _futureWarmUp = fetchWarmUp();
  }

  Future<List<dynamic>> fetchWarmUp() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/showWarmUp'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        return data['WarmUp'] ?? [];
      } else {
        throw Exception('Failed to load warm-up data');
      }
    } else {
      throw Exception('Failed to load warm-up data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warm Up Data'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureWarmUp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final warmUp = snapshot.data!;
            return ListView.builder(
              itemCount: warmUp.length,
              itemBuilder: (context, index) {
                final item = warmUp[index];
                return ListTile(
                  title: Text(item['description'] ?? 'No description'),
                  subtitle: Text('Details: ${item['details'] ?? 'No details'}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
