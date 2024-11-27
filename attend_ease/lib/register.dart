import 'package:flutter/material.dart';
import 'login.dart'; // Import login page if needed
import 'HTTP_Request/Http_connector.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _registerNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final HttpConnector _httpConnector = HttpConnector();


  void _register() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final registerNumber = _registerNumberController.text.trim();
      final password = _passwordController.text.trim();

      try {
        // Send registration data to the server
        final studentData = {

          'regno': registerNumber,
          'studentName': username,
          'password': password,
        };
        final response = await _httpConnector.createStudent(studentData);

        // Handle successful registration
        // if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );

          // Navigate to Login Page after successful registration
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          });
        // } else {
        //   // Show error message if registration fails
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Registration failed: ${response['message']}')),
        //   );
        // }
      } catch (e) {
        // Handle error if the server call fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _registerNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AttendEase',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Register Your Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _registerNumberController,
                    decoration: const InputDecoration(labelText: 'Register Number'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Register number is required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    validator: (value) =>
                    value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
