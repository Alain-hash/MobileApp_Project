import 'package:flutter/material.dart';
import 'package:flutter_application_1/ultils/AppStyles.dart';
import 'package:flutter_application_1/userPages/login.dart';
import 'package:flutter_application_1/userPages/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _HomepageState();
}

class _HomepageState extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Fitness Journey',
            style: GoogleFonts.bokor(
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                shadows: const [
                  Shadow(
                    color: Color(0xFF505050),
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, // Removes shadow for a clean look
          centerTitle: true, // Centers the title in the app bar
        ),
        extendBodyBehindAppBar: true, // Ensures the app bar floats over the background
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/1076955.jpg'), // Ensure the image path is correct
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: Container(
                    width: 115,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Styles.HomeContainerbgColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0x6C5E5F60),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle.copyWith(color: Styles.HomeTitle),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add some spacing between the buttons
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signup(),
                      ),
                    );
                  },
                  child: Container(
                    width: 115,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Styles.HomeContainerbgColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0x6C5E5F60),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle.copyWith(color: Styles.HomeTitle),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add some spacing between the buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
