import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MakeupServicesScreen extends StatefulWidget {
  const MakeupServicesScreen({super.key});

  @override
  _MakeupServicesScreenState createState() => _MakeupServicesScreenState();
}

class _MakeupServicesScreenState extends State<MakeupServicesScreen> {
  final Random _random = Random();
  String selectedMakeup = '';

  final List<String> makeupOptions = ['Glam Makeup', 'Bridal Makeup'];

  final Map<String, List<Map<String, String>>> makeupDetails = {
    'Glam Makeup': [
      {
        "title": "Soft Glam",
        "desc": "Perfect for day events",
        "image": "makeup1"
      },
      {
        "title": "Heavy Glam",
        "desc": "Bold and trendy look",
        "image": "makeup2"
      },
    ],
    'Bridal Makeup': [
      {
        "title": "Engagement/Nikkah Bride",
        "desc": "Soft bridal makeup",
        "image": "makeup3"
      },
      {
        "title": "Traditional Bride",
        "desc": "Classic bridal makeup",
        "image": "makeup4"
      },
    ],
  };

  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => (_random.nextInt(4500) + 500);

  void scrollToMakeup(String makeup) {
    final index = makeupOptions.indexOf(makeup);
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // Positions the section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extra bottom padding ensures that the last section scrolls fully to the top.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 191, 200),
        title: const Text("Makeup Services",
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
                image: AssetImage("assets/makeupmain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Horizontal toggle buttons
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeupOptions.map((makeup) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMakeup = makeup;
                    });
                    scrollToMakeup(makeup);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedMakeup == makeup
                          ? const Color.fromARGB(255, 243, 189, 207)
                              .withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.brush,
                            size: 20,
                            color: Color.fromARGB(255, 187, 137, 145)),
                        const SizedBox(width: 5),
                        Text(makeup),
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
              itemCount: makeupOptions.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final makeup = makeupOptions[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        makeup,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...makeupDetails[makeup]!.map((item) {
                      final rating = generateRating();
                      final price = generatePrice();
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
