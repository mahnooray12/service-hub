import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FacialServicesScreen extends StatefulWidget {
  @override
  _FacialServicesScreenState createState() => _FacialServicesScreenState();
}

class _FacialServicesScreenState extends State<FacialServicesScreen> {
  final Random _random = Random();
  String selectedFacial = '';

  final List<String> facials = [
    'Whitening Facial',
    'Janssen Facial',
    'Hydra Facial',
    'Skin Polisher'
  ];

  final Map<String, List<Map<String, String>>> facialDetails = {
    'Whitening Facial': [
      {
        "title": "Basic Whitening",
        "desc": "Removes dullness",
        "image": "facial1"
      },
      {
        "title": "Advanced Whitening",
        "desc": "Deep skin brightening",
        "image": "facial2"
      },
    ],
    'Janssen Facial': [
      {
        "title": "Janssen Glow",
        "desc": "Hydrating & nourishing",
        "image": "facial3"
      },
      {
        "title": "Janssen Anti-Aging",
        "desc": "Reduces fine lines",
        "image": "facial4"
      },
    ],
    'Hydra Facial': [
      {
        "title": "Deep Clean Hydra",
        "desc": "Deep pore cleansing",
        "image": "facial5"
      }
    ],
    'Skin Polisher': [
      {
        "title": "Herbal Polisher",
        "desc": "Gentle exfoliation",
        "image": "facial6"
      }
    ],
  };

  final ItemScrollController _itemScrollController = ItemScrollController();

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => (_random.nextInt(4500) + 500);

  void scrollToFacial(String facial) {
    final index = facials.indexOf(facial);
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0, // Aligns the selected section at the top.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Increase the bottom padding so the last item can scroll fully to the top.
    final bottomPadding = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 197, 221),
        title: Text("Facial Services", style: TextStyle(color: Colors.white)),
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
                image: AssetImage("assets/facialmain.jpg"),
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
              children: facials.map((facial) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFacial = facial;
                    });
                    scrollToFacial(facial);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedFacial == facial
                          ? Color.fromARGB(255, 243, 189, 207).withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.face_retouching_natural,
                            size: 20,
                            color: Color.fromARGB(255, 187, 137, 145)),
                        SizedBox(width: 5),
                        Text(facial),
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
              itemCount: facials.length,
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemBuilder: (context, index) {
                final facial = facials[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        facial,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...facialDetails[facial]!.map((item) {
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
