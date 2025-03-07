import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HairServicesScreen extends StatefulWidget {
  @override
  _HairServicesScreenState createState() => _HairServicesScreenState();
}

class _HairServicesScreenState extends State<HairServicesScreen> {
  final Random _random = Random();
  String selectedHairService = '';

  final List<String> hairServices = ['Haircut', 'Hair Dye', 'Hairstyle'];

  final Map<String, List<Map<String, String>>> hairServiceDetails = {
    'Haircut': [
      {
        "title": "Layered Cut (Short hair)",
        "desc": "Modern layered style",
        "image": "hair1"
      },
      {
        "title": "Layered Cut (long hair)",
        "desc": "Modern layered style",
        "image": "hair2"
      },
      {
        "title": "Straight Cut (Shorthair)",
        "desc": "Standard straight style",
        "image": "hair3"
      },
      {
        "title": "Straight Cut (long hair)",
        "desc": "Standard straight style",
        "image": "hair4"
      },
      {
        "title": "Wolf Cut (Short hair)",
        "desc": "Modern wolf style",
        "image": "hair5"
      },
      {
        "title": "Wolf Cut (long hair)",
        "desc": "Modern wolf style",
        "image": "hair6"
      },
      {"title": "Bob cut", "desc": "Modern boyish style", "image": "hair7"},
    ],
    'Hair Dye': [
      {
        "title": "Hair dye customised",
        "desc": "Complete hair dye",
        "image": "hair9"
      },
      {
        "title": "Hair dye application only",
        "desc": "Apply only",
        "image": "hair8"
      },
    ],
    'Hairstyle': [
      {
        "title": "Short hair style",
        "desc": "Perfectly styled short hair",
        "image": "hair10"
      },
      {
        "title": "Long hair style",
        "desc": "Sleek & smooth long hair",
        "image": "hair11"
      },
    ],
  };

  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => (_random.nextInt(4500) + 500);

  void scrollToService(String service) {
    final index = hairServices.indexOf(service);
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // This positions the selected section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Add extra bottom padding so the last section can scroll fully into view.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 191, 200),
        title: Text("Hair Services", style: TextStyle(color: Colors.white)),
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
                image: AssetImage("assets/hairmain.jpg"),
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
              children: hairServices.map((service) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedHairService = service;
                    });
                    scrollToService(service);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedHairService == service
                          ? Color.fromARGB(255, 243, 189, 207).withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.cut,
                            size: 20,
                            color: Color.fromARGB(255, 187, 137, 145)),
                        SizedBox(width: 5),
                        Text(service),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Expanded scrollable list with extra bottom padding.
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemCount: hairServices.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final service = hairServices[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        service,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...hairServiceDetails[service]!.map((item) {
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
                                  Text(rating.toStringAsFixed(1),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
