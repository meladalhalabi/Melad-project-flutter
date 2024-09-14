// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class CountdownTimer extends StatefulWidget {
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }
//
// class _CountdownTimerState extends State<CountdownTimer> {
//   int _seconds = 10;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startCountdown();
//   }
//
//   void _startCountdown() {
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       if (_seconds == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _seconds--;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Countdown: $_seconds',
//           style: TextStyle(fontSize: 24),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _seconds = 10; // Reset timer
//               _startCountdown();
//             });
//           },
//           child: Text('Start Timer'),
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
