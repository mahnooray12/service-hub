import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ElectricianServiceApp extends StatelessWidget {
  const ElectricianServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ElectricianServiceScreen(),
    );
  }
}

class ElectricianServiceScreen extends StatefulWidget {
  const ElectricianServiceScreen({super.key});

  @override
  _ElectricianServiceScreenState createState() =>
      _ElectricianServiceScreenState();
}

class _ElectricianServiceScreenState extends State<ElectricianServiceScreen> {
  String? selectedService;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final Random _random = Random();
  String searchQuery = "";

  Map<String, int> itemCounts = {};

  final Map<String, IconData> serviceIcons = {
    "Switch": Icons.electrical_services,
    "Ceiling Fan": Icons.waves,
    "Refrigerator": Icons.kitchen,
    "Wiring": Icons.cable,
    "Light": Icons.lightbulb,
    "Oven": Icons.microwave,
    "Washing Machine": Icons.local_laundry_service,
    "UPS": Icons.battery_charging_full,
  };

  List<String> services = [
    "Switch",
    "Ceiling Fan",
    "Refrigerator",
    "Wiring",
    "Light",
    "Oven",
    "Washing Machine",
    "UPS"
  ];

  Map<String, List<Map<String, String>>> subcategories = {
    "Switch": [
      {
        "image": "switch1",
        "title": "Switch Installation",
        "desc": "Install a new switch"
      },
      {
        "image": "switch2",
        "title": "Repair Damaged Switch",
        "desc": "Fix broken switches"
      }
    ],
    "Ceiling Fan": [
      {
        "image": "fan1",
        "title": "Fan Installation",
        "desc": "Install new fans"
      },
      {"image": "fan2", "title": "Fan Repairing", "desc": "Repair damaged fans"}
    ],
    "Refrigerator": [
      {
        "image": "fridge1",
        "title": "Fridge Installation",
        "desc": "Install a new fridge"
      },
      {
        "image": "fridge2",
        "title": "Fridge Repairing",
        "desc": "Repair damaged fridges"
      }
    ],
    "Wiring": [
      {
        "image": "wiring1",
        "title": "Repair Wiring",
        "desc": "Fix damaged wires"
      },
      {
        "image": "wiring2",
        "title": "Rewiring Service",
        "desc": "Rewire your home"
      }
    ],
    "Light": [
      {
        "image": "light1",
        "title": "SMD Light Installation",
        "desc": "Install SMD lights"
      },
      {
        "image": "light2",
        "title": "Fancy Light Installation",
        "desc": "Install decorative lights"
      }
    ],
    "Oven": [
      {
        "image": "oven1",
        "title": "Small Oven Repair",
        "desc": "Fix small ovens"
      },
      {
        "image": "oven2",
        "title": "Large Oven Repair",
        "desc": "Fix large ovens"
      }
    ],
    "Washing Machine": [
      {
        "image": "machine1",
        "title": "Install Washing Machine",
        "desc": "Easy installation"
      },
      {
        "image": "machine2",
        "title": "Repair Machines",
        "desc": "Fix washing machines"
      },
      {
        "image": "machine3",
        "title": "Upgrade to Automatic",
        "desc": "Upgrade your machine"
      }
    ],
    "UPS": [
      {
        "image": "ups1",
        "title": "UPS Installation",
        "desc": "Professional UPS setup"
      },
      {
        "image": "ups2",
        "title": "UPS Repair",
        "desc": "Fix malfunctioning UPS"
      },
      {
        "image": "ups3",
        "title": "UPS Wiring",
        "desc": "Reliable UPS wiring solutions"
      }
    ]
  };

  double generateRating() => (_random.nextDouble() * 2) + 3;
  int generatePrice() => (_random.nextInt(4500) + 500);

  void incrementCount(String title) {
    setState(() {
      itemCounts[title] = (itemCounts[title] ?? 0) + 1;
    });
  }

  void decrementCount(String title) {
    setState(() {
      if ((itemCounts[title] ?? 0) > 0) {
        itemCounts[title] = itemCounts[title]! - 1;
      }
    });
  }

  void scrollToService(String service) {
    final index = services.indexOf(service);
    bool isLastItem = index == services.length - 1;

    Future.delayed(const Duration(milliseconds: 200), () {
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: isLastItem ? 1.0 : 0.0, // Ensure last item is fully at top
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, String>>> filteredSubcategories = {};
    subcategories.forEach((key, value) {
      List<Map<String, String>> filteredItems = value
          .where((item) =>
              item["title"]!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item["desc"]!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      if (filteredItems.isNotEmpty) {
        filteredSubcategories[key] = filteredItems;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Electrician Services"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/elect.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query.toLowerCase();
                });
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (query.isNotEmpty) {
                    for (int i = 0; i < services.length; i++) {
                      if (subcategories[services[i]]!.any((item) =>
                          item["title"]!
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          item["desc"]!
                              .toLowerCase()
                              .contains(query.toLowerCase()))) {
                        _itemScrollController.scrollTo(
                          index: i,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                          alignment: 0.0,
                        );
                        break;
                      }
                    }
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 88, 49, 35)),
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 88, 49, 35)),
                filled: true,
                fillColor: const Color.fromARGB(255, 248, 246, 246),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: services.map((service) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedService = service;
                    });
                    final index = services.indexOf(service);
                    _itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                      alignment: 0.0, // Aligns the section at the top
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selectedService == service
                          ? Colors.brown.withOpacity(0.2)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          serviceIcons[service] ??
                              Icons.miscellaneous_services, // Default icon
                          size: 20,
                          color: Colors.brown,
                        ),
                        const SizedBox(width: 5),
                        Text(service),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemCount:
                  services.length + 1, // 🔥 Add extra blank space dynamically
              itemScrollController: _itemScrollController,
              itemBuilder: (context, index) {
                if (index == services.length) {
                  return SizedBox(
                    height: selectedService == services.last
                        ? MediaQuery.of(context).size.height * 0.6
                        : 0,
                  ); // 🔥 Adds blank space only if the last item is selected
                }

                String service = services[index];

                List<Map<String, String>> filteredSubcategories =
                    subcategories[service]!
                        .where((item) =>
                            item["title"]!
                                .toLowerCase()
                                .contains(searchQuery) ||
                            item["desc"]!.toLowerCase().contains(searchQuery))
                        .toList();

                if (filteredSubcategories.isEmpty)
                  return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        service,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...filteredSubcategories.map((item) {
                      double rating = generateRating();
                      int price = generatePrice();
                      String title = item["title"]!;
                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: const Color(0xFFF8F1E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                        index < rating.round()
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.brown),
                                onPressed: () => decrementCount(title),
                              ),
                              Text('${itemCounts[title] ?? 0}'),
                              IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.brown),
                                onPressed: () => incrementCount(title),
                              ),
                            ],
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
