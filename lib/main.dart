import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/authentication/authentication.dart';
import 'package:machinetest/authentication/otp.dart';
import 'package:machinetest/home.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/homeScreen': (BuildContext ctx) => MyHomePage(),
      },
    );
  }
}
