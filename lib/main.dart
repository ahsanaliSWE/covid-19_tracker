import 'package:covid_19_tracker/screens/splash_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
     const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Covid 19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
      
    );
  }
}


