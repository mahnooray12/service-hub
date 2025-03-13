import 'package:flutter/material.dart';
import 'package:servicehub/homescreen/homeassist/ac.dart';
import 'package:servicehub/homescreen/homeassist/electrician.dart';
import 'package:servicehub/homescreen/homeassist/plumber.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home Services"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeAssistScreen()),
            );
          },
          child: const Text("Open Services"),
        ),
      ),
    );
  }
}

class HomeAssistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> homeSubCategories = [
    {
      "name": "Electrician",
      "image": "assets/elec.jpg",
      "screen": ElectricianServiceScreen()
    },
    {
      "name": "AC Technician",
      "image": "assets/ac.jpg",
      "screen": ACTechnicianServiceApp()
    },
    {
      "name": "Plumber",
      "image": "assets/plum.jpg",
      "screen": PlumberServiceApp()
    },
    {
      "name": "Handyman",
      "image": "assets/handy.jpg",
    },
  ];

  HomeAssistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1E5),
      appBar: AppBar(
        title: const Text("Home Assist"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Ensures full width to align left
              child: const Text(
                "WHAT ARE\nYOU LOOKING \nFOR?",
                style: TextStyle(
                  fontSize: 26, // Adjust as needed
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 49, 35),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 49, 35),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildServiceBox(context, homeSubCategories[0], true,
                            false), // Electrician (small)
                        const SizedBox(height: 25),
                        _buildServiceBox(context, homeSubCategories[2], false,
                            true), // Plumber (medium)
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        _buildServiceBox(context, homeSubCategories[3], false,
                            true), // Handyman (medium)
                        const SizedBox(height: 25),
                        _buildServiceBox(context, homeSubCategories[1], true,
                            false), // AC Technician (small)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceBox(BuildContext context, Map<String, dynamic> category,
      bool isSmall, bool isMedium) {
    return GestureDetector(
      onTap: () {
        if (category["screen"] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => category["screen"],
            ),
          );
        }
      },
      child: Column(
        children: [
          // Image Container with Rounded Corners
          Container(
            height: isSmall
                ? MediaQuery.of(context).size.height * 0.15
                : isMedium
                    ? MediaQuery.of(context).size.height * 0.25
                    : MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36), // Rounded corners
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36), // Apply rounded corners
              child: Image.asset(
                category["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Service Name Below the Image (without background)
          Text(
            category["name"],
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 88, 49, 35),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
