import 'package:flutter/material.dart';
import 'package:ses_flutter_project/widgets/logo.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({Key? key}) : super(key: key);

  @override
  _StudentRegistrationPageState createState() =>
      _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _registered = false;
  String _errorMessage = '';

  void _handleRegistration() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    // Handle registration logic
    // If registration is successful, set "registered" to true
    setState(() {
      _errorMessage = '';
      _registered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/StudentRegistration.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Logo(),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Student Registration',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _registered
                  ? Column(
                      children: [
                        const Text('Registration successful!'),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            // Navigate to the login page
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Please proceed to Login'),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: _nameController,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _emailController,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: _passwordController,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ElevatedButton(
                          onPressed: _handleRegistration,
                          child: const Text('Register'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            // Navigate to the login page
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Already registered? Login here'),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
