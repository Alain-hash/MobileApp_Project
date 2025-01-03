import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/home1.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String userId;

  const Result({super.key, required this.userId});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late double age, height, weight, fatMass;
  late String gender;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    const url = 'http://alainmoussa.atwebpages.com/get_records.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': widget.userId}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            age = double.tryParse(responseData['age'].toString()) ?? 0.0;
            height = double.tryParse(responseData['height'].toString()) ?? 0.0;
            weight = double.tryParse(responseData['weight'].toString()) ?? 0.0;
            fatMass = double.tryParse(responseData['fat_mass'].toString()) ?? 0.0;
            gender = responseData['gender'] ?? '';
            isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to fetch data")),
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

  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  double calculateBFP(double bmi) {
    if (gender == 'Male') {
      return 1.20 * bmi + 0.23 * age - 16.2;
    } else {
      return 1.20 * bmi + 0.23 * age - 5.4;
    }
  }

  double calculateFFMI() {
    // Lean Body Mass (LBM) = Weight - Fat Mass
    double leanBodyMass = weight - fatMass; 
    // FFMI formula: Lean Body Mass / Height^2
    double heightInMeters = height / 100;
    return leanBodyMass / (heightInMeters * heightInMeters); // FFMI formula
  }

  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  Future<void> sendResultsToServer(String userId, double bmi, double bfp, double ffmi, double bmr) async {
    const url = 'http://alainmoussa.atwebpages.com/insert_results.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'bmi': bmi,
          'bfp': bfp,
          'ffmi': ffmi,
          'bmr': bmr,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Results saved successfully!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? "Error occurred")),
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

  void logout() {
    // Navigate to the Login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Back to previous page
            },
          ),
          title: const Text(
            'RESULTS',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()), // Show loading indicator
      );
    }

    double bmi = calculateBMI();
    double bfp = calculateBFP(bmi);
    double ffmi = calculateFFMI();
    double bmr = calculateBMR();

    sendResultsToServer(widget.userId, bmi, bfp, ffmi, bmr); // Insert results into the server

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Back to previous page
          },
        ),
        title: const Text(
          'RESULTS',
          style: TextStyle(color: Colors.black, fontSize: 20),
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
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    border: TableBorder.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    children: [
                      TableRow(
                        children: [
                          tableCell('Your BMI is:'),
                          tableCell(bmi.toStringAsFixed(1)),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableCell('Your Body Fat Percentage (BFP) is:'),
                          tableCell('${bfp.toStringAsFixed(1)}%'),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableCell('Your Fat-Free Mass Index (FFMI) is:'),
                          tableCell(ffmi.toStringAsFixed(1)),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableCell('Your Basal Metabolic Rate (BMR) is:'),
                          tableCell('${bmr.toStringAsFixed(1)} kcal/day'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40), // Added space before logout button
                  Center(
                    child: ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Set the button color to red
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 14, color: Colors.white), // Reduced font size
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

  // Helper function to create table cells with styling
  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

