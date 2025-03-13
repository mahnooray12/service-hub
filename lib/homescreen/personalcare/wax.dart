import 'dart:math';
import 'package:flutter/material.dart';
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

class WaxingServicesScreen extends StatefulWidget {
  const WaxingServicesScreen({super.key});

  @override
  _WaxingServicesScreenState createState() => _WaxingServicesScreenState();
}

class _WaxingServicesScreenState extends State<WaxingServicesScreen> {
  final Random _random = Random();
  String? selectedWaxing;

  final List<String> waxingOptions = [
    'Full Body',
    'Eyebrow & Upper Lips',
    'Arms',
    'Legs',
    'Underarms'
  ];

  final Map<String, List<Map<String, String>>> waxingDetails = {
    'Full Body': [
      {
        "title": "Sugar Wax",
        "desc": "Long-lasting smoothness",
        "image": "wax1"
      },
      {
        "title": "Fruit Wax",
        "desc": "Gentle on sensitive skin",
        "image": "wax2"
      },
    ],
    'Eyebrow & Upper Lips': [
      {"title": "Eyebrow Wax", "desc": "Perfect shaping", "image": "wax3"},
      {
        "title": "Upper Lips Wax",
        "desc": "Perfect smoothness",
        "image": "wax9"
      },
    ],
    'Arms': [
      {
        "title": "Half Arms Wax",
        "desc": "Smooth & silky finish",
        "image": "wax4"
      },
      {
        "title": "Full Arms Wax",
        "desc": "Smooth & silky finish",
        "image": "wax5"
      },
    ],
    'Legs': [
      {
        "title": "Half Legs Wax",
        "desc": "Long-lasting hair removal",
        "image": "wax6"
      },
      {
        "title": "Full Legs Wax",
        "desc": "Long-lasting hair removal",
        "image": "wax7"
      },
    ],
    'Underarms': [
      {
        "title": "Sensitive Skin Wax",
        "desc": "Gentle & effective",
        "image": "wax8"
      },
    ],
  };

  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => (_random.nextInt(4500) + 500);

  void scrollToWaxing(String waxing) {
    final index = waxingOptions.indexOf(waxing);
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // Positions the selected section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extra bottom padding ensures that even the last section scrolls fully to the top.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 191, 200),
        title: const Text("Waxing Services",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header image
          Container(
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/waxmain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Horizontal toggle buttons for waxing options
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: waxingOptions.map((waxing) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedWaxing = waxing;
                    });
                    scrollToWaxing(waxing);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedWaxing == waxing
                          ? const Color.fromARGB(255, 243, 189, 207)
                              .withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.spa,
                          size: 20,
                          color: Color.fromARGB(255, 187, 137, 145),
                        ),
                        const SizedBox(width: 5),
                        Text(waxing),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Expanded scrollable list using ScrollablePositionedList
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemCount: waxingOptions.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final waxing = waxingOptions[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        waxing,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Waxing service details for this section
                    ...waxingDetails[waxing]!.map((item) {
                      final rating = generateRating();
                      final price = generatePrice();
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset(
                            "assets/${item["image"]}.jpg",
                            width: 55,
                            height: 55,
                          ),
                          title: Text(item["title"]!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item["desc"]!),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("PKR $price",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        index < rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Book Now"),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
