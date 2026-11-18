import 'package:flutter/material.dart';
import 'demo_auth.dart';
import 'login_screen.dart';

// My student details
const String studentName = 'Angelo Ranes';
const String studentId = '534229';
const String courseSection = 'CCE106L(3450)';
const String studentEmail = 'a.ranes.534229@umindanao.edu.ph';

// The profile page showing the student's information.
class ProfilePage extends StatelessWidget {
  // The username of the logged-in student.
  final String username;

  const ProfilePage({super.key, required this.username});

  // Logs the user out, clears the session, and returns to the Login screen so
  // pressing Back does not reopen MainScreen.
  void logout(BuildContext context) {
    DemoAuth.logout();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            studentName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Logged in as: $username',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('Student ID'),
                  subtitle: Text(studentId),
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Course and Section'),
                  subtitle: Text(courseSection),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(studentEmail),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

// The student info is fixed. Only the logged-in username changes with the account.
