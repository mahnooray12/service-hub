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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Services"),
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
          child: Text("Open Services"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F1E5),
      appBar: AppBar(
        title: Text("Home Assist"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity, // Ensures full width to align left
              child: Text(
                "WHAT ARE\nYOU LOOKING \nFOR?",
                style: TextStyle(
                  fontSize: 26, // Adjust as needed
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 49, 35),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 49, 35),
                ),
              ),
            ),
            SizedBox(height: 35),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildServiceBox(context, homeSubCategories[0], true,
                            false), // Electrician (small)
                        SizedBox(height: 25),
                        _buildServiceBox(context, homeSubCategories[2], false,
                            true), // Plumber (medium)
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        _buildServiceBox(context, homeSubCategories[3], false,
                            true), // Handyman (medium)
                        SizedBox(height: 25),
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
              boxShadow: [
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
          SizedBox(height: 8),

          // Service Name Below the Image (without background)
          Text(
            category["name"],
            style: TextStyle(
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
