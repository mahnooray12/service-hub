import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ManiPediServicesScreen extends StatefulWidget {
  const ManiPediServicesScreen({super.key});

  @override
  _ManiPediServicesScreenState createState() => _ManiPediServicesScreenState();
}

class _ManiPediServicesScreenState extends State<ManiPediServicesScreen> {
  final Random _random = Random();
  String selectedCategory = '';

  final List<String> categories = ['Manicure', 'Pedicure', 'Deals'];

  final Map<String, List<Map<String, String>>> categoryDetails = {
    'Manicure': [
      {
        "title": "Basic Manicure",
        "desc": "Nail shaping & polish",
        "image": "mani1"
      },
      {
        "title": "Spa Manicure",
        "desc": "Nail shaping, glow & polish",
        "image": "mani2"
      },
    ],
    'Pedicure': [
      {
        "title": "Classic Pedicure",
        "desc": "Foot soak & exfoliation",
        "image": "pedi1"
      },
      {
        "title": "Spa Pedicure",
        "desc": "Foot soak, glow & exfoliation",
        "image": "pedi2"
      },
    ],
    'Deals': [
      {
        "title": "Combo Offer",
        "desc": "Basic Manicure + Pedicure at a discount",
        "image": "manipedi1"
      },
      {
        "title": "Jumbo Offer",
        "desc": "Spa Manicure + Pedicure at a discount",
        "image": "manipedi3"
      },
      {
        "title": "Nails Offer",
        "desc": "Manicure + Pedicure with nail polish",
        "image": "manipedi2"
      },
    ],
  };

  // Use an ItemScrollController to scroll by index.
  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() {
    return (_random.nextDouble() * 2) + 3;
  }

  int generatePrice() {
    return (_random.nextInt(4500) + 500);
  }

  void scrollToCategory(String category) {
    final index = categories.indexOf(category);
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // Positions the section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Add extra bottom padding so the last section scrolls fully to the top.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 182, 203),
        title: const Text("Mani/Pedi Services",
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
                image: AssetImage("assets/manipedimain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Horizontal toggle buttons for categories.
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                    scrollToCategory(category);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedCategory == category
                          ? const Color.fromARGB(255, 243, 189, 207)
                              .withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.spa,
                            size: 20,
                            color: Color.fromARGB(255, 187, 137, 145)),
                        const SizedBox(width: 5),
                        Text(category),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Expanded scrollable list using ScrollablePositionedList.
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemCount: categories.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...categoryDetails[category]!.map((item) {
                      double rating = generateRating();
                      int price = generatePrice();
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset("assets/${item["image"]}.jpg",
                              width: 55, height: 55),
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
                                  Text(rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
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
