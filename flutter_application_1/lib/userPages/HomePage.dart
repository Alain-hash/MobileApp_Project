// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ultils/AppStyles.dart';
import 'package:flutter_application_1/userPages/BmiCalculator.dart';
import 'package:flutter_application_1/userPages/WorkOut.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/1076955.jpg'), // Ensure the image path is correct
            ),
          ),
          child: Center(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'My Fitness Pal',
                    style: GoogleFonts.bokor(
                      textStyle: TextStyle(
                        color: const Color.fromARGB(255, 254, 253, 253).withOpacity(0.8),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        shadows: const [
                          Shadow(
                            color: Color(0xFF505050),
                            blurRadius: 30,
                            offset: Offset(4, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
               
                // Workout Button
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Workout(),
                      ),
                    );
                  },
                  child: Container(
                    width: 115,
                    height: 120,
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
                          'Workout',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle.copyWith(color: Styles.HomeTitle),
                        ),
                        Icon(Icons.sports_gymnastics),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add some spacing between the buttons

                // BMI Calculator Button
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BMI(),
                      ),
                    );
                  },
                  child: Container(
                    width: 115,
                    height: 120,
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
                          'BMI Calculator',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle.copyWith(color: Styles.HomeTitle),
                        ),
                        Icon(Icons.food_bank),
                      ],
                      
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
