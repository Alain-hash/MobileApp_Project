// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ultils/AppStyles.dart';
import 'package:flutter_application_1/userPages/HomePage.dart';
import 'package:flutter_application_1/userPages/result1.dart';
import 'package:google_fonts/google_fonts.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  List<String> TrainOptions = [
    'Strength Training',
    'Cut',
    'Recovery workout',
    'Flexibility And Mobility',
  ];

  String? selectedGov;
  int selectedRadio = -1;
  TextEditingController trainingDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedGov = TrainOptions.first;
  }

  bool _isNumeric(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    return numericRegex.hasMatch(str);
  }

  void _submitForm() {
    bool isValid = true;
    String errorMessage = '';

    // Validate training days input
    if (trainingDayController.text.isEmpty) {
      isValid = false;
      errorMessage = 'Please provide your training days.';
    } else if (!_isNumeric(trainingDayController.text)) {
      isValid = false;
      errorMessage = 'Number of days must be numeric.';
    }

    // Validate training option
    if (selectedGov == null || selectedGov!.isEmpty) {
      isValid = false;
      errorMessage = 'Please select a valid option for training type.';
    }

    // Validate radio button selection
    if (selectedRadio == -1) {
      isValid = false;
      errorMessage =
          'Please select a training focus (e.g., Powerlifting or Cardio).';
    }

    if (!isValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } else {
      double nbdays = double.tryParse(trainingDayController.text) ?? 0.0;

      // Navigate to Result1 page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result1(
            nbDaysValue: nbdays.toString(),
            selectedTraining: selectedGov,
          ),
        ),
      );
    }
  }

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
            },
          ),
          title: Text(
            'Workout',
            style: GoogleFonts.bokor(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 5, 5, 5).withOpacity(0.8),
                fontSize: 35,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                shadows: const [
                  Shadow(
                    color: Color.fromARGB(255, 255, 255, 255),
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
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  Image.asset('assets/Dumbbell-Standing-Exercises.jpg').image,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: trainingDayController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Styles.primaryColor),
                    ),
                    filled: true,
                    fillColor: Styles.bgcolor,
                    labelText: 'Select Your Training Days',
                    labelStyle: TextStyle(color: Styles.textColor),
                    hintStyle: TextStyle(color: Styles.textColor),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: DropdownButtonFormField<String>(
                  value: selectedGov,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGov = newValue!;
                    });
                  },
                  items: TrainOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Styles.primaryColor),
                    ),
                    filled: true,
                    fillColor: Styles.bgcolor,
                    labelStyle: TextStyle(color: Styles.textColor),
                    hintStyle: TextStyle(color: Styles.textColor),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        "Power Lifting",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setSelectedRadio(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        "Cardio",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setSelectedRadio(value!);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 6, 6, 6),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Generate Result',
                    style: TextStyle(color: Styles.HomeTitle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
