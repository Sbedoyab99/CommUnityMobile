import 'package:community/layout/common_layout.dart';
import 'package:community/screens/apartment_screen.dart';
import 'package:community/screens/home_screen.dart';
import 'package:community/screens/login_screen.dart';
import 'package:community/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Flutter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const CommonLayout(),
      },
    );
  }
}
