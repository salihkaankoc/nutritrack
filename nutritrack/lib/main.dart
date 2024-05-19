import 'package:flutter/material.dart';
import 'package:nutritrack/commons/bottom_bar.dart';
import 'package:nutritrack/screens/home.dart';
import 'package:nutritrack/screens/login.dart';
import 'package:nutritrack/screens/otp_verification.dart';
import 'package:nutritrack/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: {
        "/": (context) => const MyBottomBar(),
        "/home": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/otp": (context) => OtpVerification(),
      },
    );
  }
}
