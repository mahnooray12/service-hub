import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NailServicesScreen extends StatefulWidget {
  @override
  _NailServicesScreenState createState() => _NailServicesScreenState();
}

class _NailServicesScreenState extends State<NailServicesScreen> {
  final Random _random = Random();
  String selectedNailService = '';

  final List<String> nailServices = [
    'Classic',
    'Acrylic',
    'French',
    'Stiletto'
  ];

  final Map<String, List<Map<String, String>>> nailServiceDetails = {
    'Classic': [
      {
        "title": "Basic Nail Polish",
        "desc": "Simple and elegant",
        "image": "nail1"
      },
      {"title": "Basic Nails", "desc": "Simple and elegant", "image": "nail2"},
    ],
    'Acrylic': [
      {
        "title": "Acrylic Nail Extensions",
        "desc": "Long-lasting and stylish",
        "image": "nail3"
      },
      {
        "title": "Acrylic Nail Extensions (Customized)",
        "desc": "Unique designs available",
        "image": "nail4"
      },
    ],
    'French': [
      {"title": "French Nails", "desc": "Timeless beauty", "image": "nail5"},
      {
        "title": "French Nails (Customized)",
        "desc": "Elegant and classic",
        "image": "nail6"
      },
    ],
    'Stiletto': [
      {"title": "Stiletto Nails", "desc": "Bold and trendy", "image": "nail7"},
      {
        "title": "Stiletto Nails (Customized)",
        "desc": "Fierce and stylish",
        "image": "nail8"
      },
    ],
  };

  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => _random.nextInt(500) + 1000;

  void scrollToService(String service) {
    final index = nailServices.indexOf(service);
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // This positions the selected section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extra bottom padding ensures the last section scrolls fully to the top.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 191, 200),
        title: Text("Nail Services", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header image
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/nailmain.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Horizontal toggle buttons
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: nailServices.map((service) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedNailService = service;
                    });
                    scrollToService(service);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedNailService == service
                          ? Color.fromARGB(255, 243, 189, 207).withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.brush,
                          size: 20,
                          color: Color.fromARGB(255, 187, 137, 145),
                        ),
                        SizedBox(width: 5),
                        Text(service),
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
              itemCount: nailServices.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final service = nailServices[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        service,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Service details
                    ...nailServiceDetails[service]!.map((item) {
                      final rating = generateRating();
                      final price = generatePrice();
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset("assets/${item["image"]}.jpg",
                              width: 55, height: 55),
                          title: Text(item["title"]!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item["desc"]!),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("PKR $price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  SizedBox(width: 10),
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
                                  SizedBox(width: 5),
                                  Text(
                                    rating.toStringAsFixed(1),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: Text("Book Now"),
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
