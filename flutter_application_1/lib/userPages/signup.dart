import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/home1.dart';
import 'package:flutter_application_1/userPages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _username = '';
  String _email = '';
  String _password = '';
  String statusMessage = '';

  void updateName(String text) {
    setState(() {
      _username = text;
    });
  }

  void updateEmail(String text) {
    setState(() {
      _email = text;
    });
  }

  void updatePassword(String text) {
    setState(() {
      _password = text;
    });
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> registerUser() async {
    final url = Uri.parse('http://alainmoussa.atwebpages.com/insert_user.php');

    try {
      final response = await http.post(
        url,
        body: {
          'username': _username.trim(),
          'email': _email.trim(),
          'password': _password.trim(),
        },
      );

      if (response.statusCode == 200) {
        if (response.body.trim().toLowerCase() == 'success') {
          setState(() {
            statusMessage = 'User registered successfully!';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully!')),
          );
        } else {
          setState(() {
            statusMessage =
                response.body.trim(); // Display raw response message
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body.trim())),
          );
        }
      } else {
        setState(() {
          statusMessage = 'Server Error: ${response.statusCode}';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        statusMessage = 'Error: $e';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _submitForm() {
    if (_username.isEmpty || _email.isEmpty || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields.')),
      );
    } else if (!_isEmailValid(_email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
    } else {
      registerUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home1()),
              );
            },
          ),
          title: Text(
            'Sign up',
            style: GoogleFonts.bokor(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                fontSize: 35,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                shadows: const [
                  Shadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 30,
                    offset: Offset(4, 2),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Dumbbell-Standing-Exercises.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (text) {
                        updateName(text);
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (text) {
                        updateEmail(text);
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (text) {
                        updatePassword(text);
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      minimumSize: WidgetStateProperty.all(const Size(200, 50)),
                    ),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
