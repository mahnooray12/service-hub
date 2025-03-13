import 'dart:math';
import 'package:flutter/material.dart';

class ChickenMenuScreen extends StatelessWidget {
  final List<Map<String, String>> chickenItems = [
    {
      "title": "Whole Chicken",
      "desc": "Perfect for your Dawat!",
      "image": "wholechicken"
    },
    {
      "title": "Leg Piece",
      "desc": "Crispy, juicy, and flavorful!",
      "image": "legpiece"
    },
    {
      "title": "Boneless ",
      "desc": "Get the best boneless chicken ",
      "image": "chest"
    },
    {"title": "Wings", "desc": "Bite-sized delight!", "image": "wings"},
  ];

  final Random _random = Random();

  ChickenMenuScreen({super.key});

  double generateRandomPrice() {
    return (800 + _random.nextDouble() * 500).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 152, 181),
        title:
            const Text("Chicken Menu", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/chickenmain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color.fromARGB(207, 158, 64, 88),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            padding: const EdgeInsets.all(12),
            child: Card(
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset("assets/wholechicken.jpg",
                    width: 75, height: 75),
                title: const Text(
                  "Whole Chicken",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "Perfect for your Dawat! - Rs. ${generateRandomPrice().toStringAsFixed(2)} per kg"),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(226, 175, 53, 83),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  child: const Text("Add",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chickenItems.length - 1,
              itemBuilder: (context, index) {
                final item = chickenItems[index + 1];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset("assets/${item["image"]}.jpg",
                        width: 55, height: 55),
                    title: Text(item["title"]!),
                    subtitle: Text(
                        "${item["desc"]!} - Rs. ${generateRandomPrice().toStringAsFixed(2)} per kg"),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Add"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
