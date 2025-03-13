import 'package:flutter/material.dart';
import 'package:servicehub/authentication/signin.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  final String customerName;

  const WelcomeScreen({super.key, required this.customerName});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<String> images = [
    "assets/cartt.jpg",
    "assets/electrician.jpg",
    "assets/maid.jpeg",
    "assets/makeup.jpeg",
    "assets/driver.jpg",
    "assets/event1.jpg"
  ];

  final List<String> slogans = [
    "Craving for Some Fresh Vegetables? We got you!",
    "Power up your home with expert electricians!",
    "Reliable maids, stress-free living!",
    "Glam up with our top-notch beauty experts!",
    "Smooth rides, anytime, anywhere!",
    "Turning your dreams into unforgettable events!"
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1E5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome to Service Hub",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(248, 143, 83, 83),
            ),
          ),
          const SizedBox(height: 15), // Reduced space
          SizedBox(
            height: 370, // Reduced height so button moves up
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align content to the top
                  children: [
                    Container(
                      height: 55, // Slightly reduced text height
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Text(
                        slogans[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(248, 143, 83, 83),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildImage(images[index]),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15), // Reduced space before button
          _buildButton("Get Started", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInSignUpScreen()),
            );
          }, Colors.brown),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 290, // Adjusted for better spacing
      height: 220, // Reduced image height to move button up
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 6,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
