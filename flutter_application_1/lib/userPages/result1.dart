import 'package:flutter/material.dart';

class Result1 extends StatelessWidget {
  final String nbDaysValue;
  final String? selectedTraining;
  final int? selectedRadio;

  const Result1({
    required this.nbDaysValue,
    required this.selectedTraining,
    this.selectedRadio,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int days = int.tryParse(nbDaysValue) ?? 0;
    String workoutDescription = '';

    // Generate a description based on selected training and other inputs
    if (selectedTraining == 'Strength Training' &&
        nbDaysValue == '1' &&
        selectedRadio == 1) {
      workoutDescription = "Focus on heavy compound lifts for strength.";
    } else if (selectedTraining == 'Strength Training' && days > 3) {
      workoutDescription =
          "Great consistency! Ensure you are progressively overloading.";
    } else if (selectedTraining == 'Cut' && selectedRadio == 2) {
      workoutDescription =
          "Combine cardio with a caloric deficit for effective cutting.";
    } else if (selectedTraining == 'Recovery workout') {
      workoutDescription = "Low-intensity movements to help your muscles recover.";
    } else if (selectedTraining == 'Flexibility And Mobility') {
      workoutDescription = "Stretch and improve your range of motion.";
    } else {
      workoutDescription = "Your chosen workout details need more refinement.";
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Return to the workout page
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
                  // Display training days
                  Text(
                    'Training Days: $days days',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  // Display selected training type
                  Text(
                    'Selected Training Type: $selectedTraining',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  // Description of the workout
                  const Text(
                    'Workout Description:',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    workoutDescription,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 20.0),
                  // Suggested focus based on training days
                  const Text(
                    'Suggested Focus:',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    days > 5
                        ? 'You are on a consistent and ambitious schedule! Stay hydrated and get adequate rest.'
                        : 'A lighter schedule is fine! Just ensure your sessions are impactful.',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
