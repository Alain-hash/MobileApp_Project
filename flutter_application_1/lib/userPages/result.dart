import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/BmiCalculator.dart';

class Result extends StatelessWidget {
  final String breakfastValue;
  final String lunchValue;
  final String dinnerValue;
  final double bmi;

  // Constructor to accept the parameters when the page is created
  const Result({
    super.key,
    required this.breakfastValue,
    required this.lunchValue,
    required this.dinnerValue,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BMI()),
            );
          },
        ),
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
                'assets/1076955.jpg'), // Ensure the image path is correct
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            // Added SingleChildScrollView for responsiveness
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey
                    .withOpacity(0.7), // Grey background with opacity
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content vertically
                children: [
                  const SizedBox(height: 20.0),
                  // First conditional block
                  if (breakfastValue == 'Oatmeal' ||
                      breakfastValue == 'Cereal' ||
                      lunchValue == 'Chicken Breast' ||
                      dinnerValue == 'Protein Shake' ||
                      dinnerValue == 'Steak')
                    const Text(
                      'Good!',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )
                  else
                    const Text(
                      'Poor!',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  const SizedBox(height: 20.0),
                  // BMI text
                  Text(
                    'Your BMI is:'
                    '$bmi',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  // BMI conditionals
                  if (bmi < 18.5)
                    const Text(
                      'You are underweight.',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 184, 0, 0)),
                    )
                  else if (bmi >= 18.5 && bmi < 24.9)
                    const Text(
                      'You have a normal weight.',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    )
                  else
                    const Text(
                      'You are overweight.',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  const SizedBox(height: 20.0),
                  // Diet recommendation conditionals
                  if (breakfastValue == 'Hot dog' ||
                      lunchValue == 'Pizza' ||
                      lunchValue == 'Burger' ||
                      dinnerValue == 'Cake')
                    const Text(
                      'Recommended: Try to add more proteins in your diet!',
                      style: TextStyle(color: Colors.white),
                    )
                  else
                    const Text(
                      'Recommended: Your diet is good! Keep it up',
                      style: TextStyle(color: Colors.white),
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
