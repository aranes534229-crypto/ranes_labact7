import 'package:flutter/material.dart';

// The dashboard page shown as the first tab after login.
class DashboardPage extends StatelessWidget {
  // The username of the logged-in student.
  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.dashboard, size: 80, color: Colors.indigo),
          const SizedBox(height: 16),
          Text(
            'Welcome, $username!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Explore your student application using the navigation bar below.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.calculate),
                  title: const Text('Calculator'),
                  subtitle: const Text('Perform basic arithmetic operations.'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Social'),
                  subtitle: const Text('Create posts, like posts, and add comments.'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  subtitle: const Text('View student information and log out.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Trace:
// logging in as admin must display exactly "Welcome, admin!".
// The Dashboard lists Calculator, Social, and Profile as navigation targets.
