import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'register.dart';
import 'HTTP_Request/Http_connector.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      routes: {
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _registerNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final HttpConnector _httpConnector = HttpConnector();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here (e.g., check credentials)
      final regNo = _registerNumberController.text.trim();
      final password = _passwordController.text.trim();
      try {
        // Fetch student details from the server
        final studentData = await _httpConnector.getStudentByRegNo(regNo);
        Map<String,dynamic> mp={};
        mp['password'] = _passwordController.text;
        if (await _httpConnector.validatePassword(_registerNumberController.text, mp)) {
          print(await _httpConnector.validatePassword(_registerNumberController.text, mp));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('registerNumber', regNo);

          // Navigate to Home Page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHome()),
          );
        } else {
          // Show error if the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Register Number or Password')),
          );
        }
      } catch (e) {
        // Handle error if the server call fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _registerNumberController.dispose();
    _passwordController.dispose();
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login to Your Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Register Number Field
                      TextFormField(
                        controller: _registerNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Register Number',
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Register Number is required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Password is required'
                            : null,
                      ),
                      const SizedBox(height: 32),
                      // Login Button
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Click here.",
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
        ),
      ),
    );
  }
}
