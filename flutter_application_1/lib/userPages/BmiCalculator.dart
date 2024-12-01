import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/HomePage.dart';

import 'result.dart';
import 'package:google_fonts/google_fonts.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  String dropdownvalue1 = 'Breakfast';
  String dropdownvalue2 = 'Lunch';
  String dropdownvalue3 = 'Dinner';

  var items1 = [
    'Breakfast',
    'Oatmeal',
    'Cereal',
    'Hotdog',
  ];

  var items2 = [
    'Lunch',
    'Burger',
    'Pizza',
    'Chicken Breast',
  ];

  var items3 = [
    'Dinner',
    'Steak',
    'Protein Shake',
    'Cake',
  ];

  String _height = '';
  String _weight = '';
  String _age = '';

  int? selectedOption = -1;

  void updateHeight(String text) {
    setState(() {
      _height = text;
    });
  }

  void updateWeight(String text) {
    setState(() {
      _weight = text;
    });
  }

  void updateAge(String text) {
    setState(() {
      _age = text;
    });
  }

  bool _isNumeric(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    return numericRegex.hasMatch(str);
  }

  void _submitForm() {
    bool isValid = true;
    String errorMessage = '';

    if (_height.isEmpty || _weight.isEmpty || _age.isEmpty) {
      isValid = false;
      errorMessage = 'Please fill in all the fields.';
    } else if (!_isNumeric(_height) ||
        !_isNumeric(_weight) ||
        !_isNumeric(_age)) {
      isValid = false;
      errorMessage = 'Height, weight, and age must be numeric.';
    }

    if (dropdownvalue1 == 'Breakfast' ||
        dropdownvalue2 == 'Lunch' ||
        dropdownvalue3 == 'Dinner') {
      isValid = false;
      errorMessage = 'Please select a valid option for all meals.';
    }

    if (selectedOption == -1) {
      isValid = false;
      errorMessage = 'Please select a gender.';
    }

    if (!isValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } else {
      double heightInMeters = double.tryParse(_height) ?? 0.0;
      double weightInKg = double.tryParse(_weight) ?? 0.0;
      double bmi = weightInKg / (heightInMeters * heightInMeters);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            breakfastValue: dropdownvalue1,
            lunchValue: dropdownvalue2,
            dinnerValue: dropdownvalue3,
            bmi: bmi,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap everything inside the SafeArea widget
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Homepage()));
            },
          ),
          title: Text(
            'BMI',
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
              image: AssetImage('assets/Dumbbell-Standing-Exercises.jpg'), // Your background image
              fit: BoxFit.cover, // Ensure the image covers the entire screen
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              // To allow scrolling if the keyboard appears
              child: Column(
                children: [
                  
                  // Centered Breakfast Dropdown
                  Align(
                    alignment: Alignment.center,
                    child: DropdownButton(
                      style: const TextStyle(color: Colors.white),
                      value: dropdownvalue1,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      items: items1.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(color: Color.fromARGB(255, 155, 155, 155))));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue1 = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Lunch Dropdown
                  DropdownButton(
                    style: const TextStyle(color: Colors.white),
                    value: dropdownvalue2,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white),
                    items: items2.map((String item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: const TextStyle(color: Color.fromARGB(255, 155, 155, 155))));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue2 = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Dinner Dropdown
                  DropdownButton(
                    style: const TextStyle(color: Colors.white),
                    value: dropdownvalue3,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white),
                    items: items3.map((String item) {
                      return DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: const TextStyle(color: Color.fromARGB(255, 155, 155, 155))));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue3 = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Height TextField with Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your height (m)',
                        hintStyle: TextStyle(
                            color: Colors.white), // Make hint text white
                      ),
                      onChanged: (text) {
                        updateHeight(text);
                      },
                    ),
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Weight TextField with Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your weight (kg)',
                        hintStyle: TextStyle(
                            color: Colors.white), // Make hint text white
                      ),
                      onChanged: (text) {
                        updateWeight(text);
                      },
                    ),
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Age TextField with Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your age',
                        hintStyle: TextStyle(
                            color: Colors.white), // Make hint text white
                      ),
                      onChanged: (text) {
                        updateAge(text);
                      },
                    ),
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Centered Gender Radio Buttons
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // To prevent the row from stretching
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        const Text('Female',
                            style: TextStyle(color: Colors.white)),
                        Radio<int>(
                          value: 1,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        const Text('Male',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 10.0), // Reduced space between elements

                  // Submit Button with White Color and Bigger Size
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      minimumSize: WidgetStateProperty.all(
                          const Size(200, 50)), // Make the button bigger
                    ),
                    child: const Text('Submit',
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
