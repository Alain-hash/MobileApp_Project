import 'package:flutter/material.dart';
import 'package:flutter_application_1/ultils/AppStyles.dart';
import 'package:flutter_application_1/userPages/result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Records extends StatefulWidget {
  final String userId;

  const Records({super.key, required this.userId});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  String gender = 'Male';

  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController fatMassController = TextEditingController();

  Future<void> sendDataToServer() async {
    const url = 'http://alainmoussa.atwebpages.com/insert_records.php';
    try {
      // Input validation
      if (ageController.text.isEmpty ||
          heightController.text.isEmpty ||
          weightController.text.isEmpty ||
          fatMassController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required")),
        );
        return;
      }

      final response = await http.post(Uri.parse(url), body: {
        'user_id': widget.userId,
        'age': ageController.text,
        'height': heightController.text,
        'weight': weightController.text,
        'fat_mass': fatMassController.text,
        'gender': gender,
      });

      if (response.statusCode == 200) {
        // Print the response body for debugging
        print("Response Body: ${response.body}");

        try {
          final responseData = jsonDecode(response.body); // Decode JSON response
          if (responseData['status'] == 'success') {
            // Successfully inserted data, now navigate to Result page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Result(userId: widget.userId), // Pass userId only
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData['message'])),
            );
          }
        } catch (error) {
          // If the response body isn't valid JSON, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error decoding response: $error")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to connect to the server")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Print userId in the debug console
    print("User ID: ${widget.userId}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'BMI Analysis Generator',
            style: GoogleFonts.bokor(
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.8),
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
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/1076955.jpg'),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the userId
                  Text(
                    'User ID: ${widget.userId}',
                    style: GoogleFonts.bokor(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildStyledTextField('Age', ageController),
                  const SizedBox(height: 10),
                  buildStyledTextField('Height (cm)', heightController),
                  const SizedBox(height: 10),
                  buildStyledTextField('Weight (kg)', weightController),
                  const SizedBox(height: 10),
                  buildStyledTextField('Fat Mass (kg)', fatMassController),
                  const SizedBox(height: 10),
                  Text(
                    'Select Gender:',
                    style: GoogleFonts.bokor(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: GoogleFonts.bokor(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: GoogleFonts.bokor(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: sendDataToServer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.HomeContainerbgColor,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Generate Result',
                        style: GoogleFonts.bokor(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStyledTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.bokor(
          textStyle: TextStyle(
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
