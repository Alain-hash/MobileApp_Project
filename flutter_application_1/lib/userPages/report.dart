import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool isLoading = true;
  List<Map<String, dynamic>> users = [];
  double averageBMI = 0.0;

  @override
  void initState() {
    super.initState();
    fetchUsersData();
  }

  Future<void> fetchUsersData() async {
    const url = 'http://alainmoussa.atwebpages.com/get_allData.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            users = List<Map<String, dynamic>>.from(responseData['data']);
            averageBMI = calculateAverageBMI();
            isLoading = false;
          });
        } else {
          showError(responseData['message'] ?? "Failed to fetch user data.");
        }
      } else {
        showError("Failed to connect to the server.");
      }
    } catch (error) {
      showError("An error occurred: $error");
    }
  }

  double calculateAverageBMI() {
    double totalBMI = 0.0;
    int count = 0;

    for (var user in users) {
      if (user['bmi'] != null) {
        double bmiValue = double.tryParse(user['bmi'].toString()) ?? 0.0;
        totalBMI += bmiValue;
        count++;
      }
    }

    return count > 0 ? totalBMI / count : 0.0;
  }

  String predictBMIStatus(double averageBMI) {
    if (averageBMI < 18.5) {
      return "The people in your system are classified as Underweight";
    } else if (averageBMI >= 18.5 && averageBMI < 24.9) {
      return "The people in your system are classified as Normal weight";
    } else if (averageBMI >= 25 && averageBMI < 29.9) {
      return "The people in your system are classified as Overweight";
    } else {
      return "The people in your system are classified as Obese";
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            'BMI Report',
            style: GoogleFonts.bokor(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
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
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/1076955.jpg'),
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Table and No Data Message
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: users.isNotEmpty
                            ? Table(
                                border: TableBorder.all(
                                  color: Colors.white.withOpacity(0.8),
                                  width: 1,
                                ),
                                columnWidths: const {
                                  0: FixedColumnWidth(100),
                                  1: FixedColumnWidth(50),
                                  2: FixedColumnWidth(100),
                                  3: FixedColumnWidth(100),
                                  4: FixedColumnWidth(50),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      tableCell('Username'),
                                      tableCell('Age'),
                                      tableCell('Height (cm)'),
                                      tableCell('Weight (kg)'),
                                      tableCell('BMI'),
                                    ],
                                  ),
                                  ...users.map((user) {
                                    return TableRow(
                                      children: [
                                        tableCell(user['username']),
                                        tableCell(user['age'].toString()),
                                        tableCell(user['height'].toString()),
                                        tableCell(user['weight'].toString()),
                                        tableCell(
                                          (double.tryParse(user['bmi'].toString()) ?? 0.0)
                                              .toStringAsFixed(1),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              )
                            : Center(
                                child: Text(
                                  'No data available',
                                  style: GoogleFonts.bokor(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      // Average BMI and Prediction
                      Text(
                        "Average BMI: ${averageBMI.toStringAsFixed(1)}",
                        style: GoogleFonts.bokor(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Prediction: ${predictBMIStatus(averageBMI)}",
                        style: GoogleFonts.bokor(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
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

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: GoogleFonts.bokor(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
