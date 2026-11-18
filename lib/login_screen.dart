import 'package:flutter/material.dart';
import 'demo_auth.dart';
import 'main_screen.dart';
import 'register_screen.dart';

// The login screen where the user enters credentials to access the app.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State for LoginScreen. Holds the form key, controllers, and password visibility.
class _LoginScreenState extends State<LoginScreen> {
  // Key that identifies the form so its fields can be validated together.
  final formKey = GlobalKey<FormState>();

  // Controllers read the text entered in the username and password fields.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // When true the password field hides its characters.
  bool hidePassword = true;

  // Validates the form, checks credentials via DemoAuth, navigates to
  // MainScreen on success (pushReplacement replaces Login with MainScreen),
  // or shows an error SnackBar on failure.
  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final isValid = DemoAuth.login(
      usernameController.text.trim(),
      passwordController.text,
    );

    if (isValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password.')),
      );
    }
  }

  // Releases the controllers when this screen is removed.
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_person, size: 80, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter your username.'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: hidePassword ? 'Show password' : 'Hide password',
                    icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your password.'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: login, child: const Text('Login')),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text("Don't have an account? Register"),
              ),
              const SizedBox(height: 24),
              const Text(
                'Default account: admin / admin123',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Trace:
// Tap Login -> validate fields (empty fields show a message) -> check DemoAuth.
// If valid: pushReplacement replaces Login with MainScreen so Back cannot reopen it.
// If invalid: show 'Invalid username or password.' SnackBar.
// Tap Register -> push to RegisterScreen.
// setState() toggles password visibility when the visibility icon is tapped.
