// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:workour_application/selectgender.dart';
// import 'controll/cll.dart';
//
// class Signin extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<Signin> {
//   final _formKey = GlobalKey<FormState>();
//   final ControllerA ctrll = Get.put(ControllerA());
//
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//
//             Text(
//               "Welcome to Workout",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         height: double.infinity,
//         color: Colors.white,
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     border: Border.all(color: Colors.black38),
//                   ),
//                   child: Image.asset("images/fitness.png"),
//                   height: 150,
//                 ),
//                 SizedBox(height: 50),
//                 Center(
//                   child: Text(
//                     "Please enter your information",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 // First Name TextFormField
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "First Name",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     counterText: '', // Hide counter
//                   ),
//                   maxLength: 8,
//                   onChanged: (value) => ctrll.setFirstName(value),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your first name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 // Last Name TextFormField
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Last Name",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     counterText: '', // Hide counter
//                   ),
//                   maxLength: 8,
//                   onChanged: (value) => ctrll.setLastName(value),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your last name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 // Username TextFormField
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Username",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     counterText: '', // Hide counter
//                   ),
//                   maxLength: 20,
//                   onChanged: (value) => ctrll.setUsername(value),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your username';
//                     }
//                     if (!value.endsWith('@gmail.com')) {
//                       return 'Username must end with @gmail.com';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 // Password TextFormField
//                 TextFormField(
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.blueGrey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     counterText: '', // Hide counter
//                   ),
//                   maxLength: 10,
//                   onChanged: (value) => ctrll.setPassword(value),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 // Confirm Password TextFormField
//                 TextFormField(
//                   obscureText: !_isConfirmPasswordVisible,
//                   decoration: InputDecoration(
//                     labelText: "Confirm Password",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.blueGrey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                         });
//                       },
//                     ),
//                     counterText: '', // Hide counter
//                   ),
//                   maxLength: 10,
//                   onChanged: (value) => ctrll.setConfirmPassword(value),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     if (value != ctrll.password.value) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: double.infinity,
//                   child: MaterialButton(
//                     color: Colors.blueGrey,
//                     padding: EdgeInsets.all(10),
//                     height: 60,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Sign In",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         print('First Name: ${ctrll.firstName.value}');
//                         print('Last Name: ${ctrll.lastName.value}');
//                         print('Username: ${ctrll.username.value}');
//                         print('Password: ${ctrll.password.value}');
//
//                     Get.to(() => SelectGender());
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Please correct the errors above'),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
