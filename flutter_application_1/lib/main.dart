import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/HomePage.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80), // Adjust the height of the AppBar
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0, // Remove AppBar shadow
//           title: const Center(
//             child: Text(
//               'Fitness App',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           // Background Image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/camera-accessories-arranged-concrete-background.jpg', // Replace with your image
//               fit: BoxFit.cover,
//             ),
//           ),
//           SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 // Banner Image Section
//                 Container(
//                   height: 250,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/fitness_banner.jpg'), // Replace with your banner image
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Get Fit, Stay Healthy!',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Feature Cards
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: <Widget>[
//                       FeatureCard(
//                         title: 'Workouts',
//                         icon: Icons.fitness_center,
//                         onTap: () {
//                           // navigate to workouts page
//                         },
//                       ),
//                       FeatureCard(
//                         title: 'Nutrition',
//                         icon: Icons.local_dining,
//                         onTap: () {
//                           // navigate to nutrition page
//                         },
//                       ),
//                       FeatureCard(
//                         title: 'Progress',
//                         icon: Icons.show_chart,
//                         onTap: () {
//                           // navigate to progress page
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Profile',
//           ),
//         ],
//         onTap: (index) {
//           // Handle bottom navigation
//         },
//       ),
//     );
//   }
// }

// class FeatureCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final VoidCallback onTap;

//   const FeatureCard({super.key, required this.title, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           size: 40,
//           color: Colors.green,
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios),
//         onTap: onTap,
//       ),
//     );
 //}
 //}

