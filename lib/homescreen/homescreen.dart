import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servicehub/drawer/sidedrawer.dart';
import 'package:servicehub/homescreen/eventdecor/event.dart';
import 'package:servicehub/homescreen/freshcart/freshcart.dart';
import 'package:servicehub/homescreen/homeassist/homeassist.dart';
import 'package:servicehub/homescreen/lifestyle/lifestyle.dart';
import 'package:servicehub/homescreen/personalcare/personalcare.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  List<Map<String, dynamic>> categories = [
    {
      "name": "Home Assist",
      "icon": Icons.home,
      "screen": HomeAssistScreen(),
      "image": "assets/h2.jpg"
    },
    {
      "name": "Lifestyle Assistance",
      "icon": Icons.spa,
      "screen": LifestyleAssistanceDialog(),
      "image": "assets/h1.jpg"
    },
    {
      "name": "Personal Care",
      "icon": Icons.brush,
      "screen": PersonalCareDialog(),
      "image": "assets/h3.jpg"
    },
    {
      "name": "Fresh Cart",
      "icon": Icons.shopping_cart,
      "screen": FreshCartDialog(),
      "image": "assets/h4.jpg"
    },
    {
      "name": "Event Decor",
      "icon": Icons.celebration,
      "screen": EventDecorDialog(),
      "image": "assets/h5.jpg"
    },
  ];

  List<Map<String, dynamic>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories); // Show all categories initially
    _searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    String query = _searchController.text.toLowerCase().trim();
    setState(() {
      filteredCategories = categories
          .where((category) => category["name"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1E5),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        //Color(0xFFF8F1E5),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to any color
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 250, 249, 249)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout,
                color: Color.fromARGB(255, 250, 249, 249)),
            onPressed: () async {
              bool? confirmLogout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false), // Cancel
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true), // Confirm
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );

              if (confirmLogout == true) {
                await signOut();
              }
            },
          ),
          // Add a logout button
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap the Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 248, 246, 246),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Explore",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),
              const SizedBox(height: 15),
              SizedBox(
                height: 360, // Increased height for bigger boxes
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              filteredCategories[index]['screen'],
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        margin: EdgeInsets.only(
                          right: 20,
                          left: index == 0 ? 30 : 0,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                              child: Image.asset(
                                filteredCategories[index]['image'],
                                width: double.infinity,
                                height: 260,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      filteredCategories[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.brown),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(filteredCategories[index]['icon'],
                                            size: 20, color: Colors.brown),
                                        const SizedBox(width: 5),
                                        const Text("Tap for further details",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text("Additional Service",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),
              const SizedBox(height: 15),

              // 🔥 Cab Service with Image & Icon beside "Safe & Fast Rides"
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 160, // Increased height
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        child: Image.asset(
                          "assets/h6.jpg", // Your cab service image
                          width: 210, // Adjust width as needed
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cab Service",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.brown),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.local_taxi,
                                      size: 22,
                                      color: Colors.brown), // 🚖 Cab Icon
                                  SizedBox(width: 6),
                                  Text(
                                    "Safe & fast rides",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
