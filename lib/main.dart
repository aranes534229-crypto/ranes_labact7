import 'package:flutter/material.dart';
import 'login_screen.dart';

// Entry point of the app.
void main() {
  runApp(const StudentApp());
}

// The root widget of the app. Configures MaterialApp with Material 3,
// an indigo seed color, and the LoginScreen as the first screen shown.
class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Checkpoint: the Login screen appears first when the app starts.
      home: const LoginScreen(),
    );
  }
}
