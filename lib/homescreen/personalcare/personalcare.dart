import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:servicehub/homescreen/personalcare/facial.dart';
import 'package:servicehub/homescreen/personalcare/hair.dart';
import 'package:servicehub/homescreen/personalcare/makeup.dart';
import 'package:servicehub/homescreen/personalcare/manipedi.dart';
import 'package:servicehub/homescreen/personalcare/massage.dart';
import 'package:servicehub/homescreen/personalcare/nail.dart';
import 'package:servicehub/homescreen/personalcare/threading.dart';
import 'package:servicehub/homescreen/personalcare/wax.dart';

class PersonalCareDialog extends StatelessWidget {
  final List<Map<String, dynamic>> personalCareSubCategories = [
    {
      "name": "Facial",
      "image": "assets/fac.png",
      "screen": FacialServicesScreen()
    },
    {
      "name": "Mani/Pedi",
      "image": "assets/mani.png",
      "screen": ManiPediServicesScreen()
    },
    {
      "name": "Wax",
      "image": "assets/wax.png",
      "screen": WaxingServicesScreen()
    },
    {
      "name": "Threading",
      "image": "assets/threading.png",
      "screen": ThreadingServicesScreen()
    },
    {
      "name": "Hair",
      "image": "assets/haircut.png",
      "screen": HairServicesScreen()
    },
    {
      "name": "Makeup",
      "image": "assets/makeup.png",
      "screen": MakeupServicesScreen()
    },
    {
      "name": "Nails",
      "image": "assets/nails.png",
      "screen": NailServicesScreen()
    },
    {
      "name": "Massage",
      "image": "assets/massage.png",
      "screen": MassageServicesScreen()
    },
  ];

  PersonalCareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Popular services",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: personalCareSubCategories.length,
                    itemBuilder: (context, index) {
                      final subcategory = personalCareSubCategories[index];

                      // Adjusting specific image sizes
                      double imageSize = 100;
                      double bottomOffset = 5;
                      double rightOffset = 15;
                      if (subcategory["name"] == "Waxing") {
                        imageSize = 130;
                        bottomOffset = -20;
                        rightOffset = -10;
                      } else if (subcategory["name"] == "Mani/Pedi") {
                        imageSize = 100;
                        bottomOffset = -10;
                        rightOffset = -10;
                      } else if (subcategory["name"] == "Makeup") {
                        imageSize = 170;
                        bottomOffset = -40;
                        rightOffset = -20;
                      } else if (subcategory["name"] == "Massage") {
                        imageSize = 130;
                        bottomOffset = -12;
                        rightOffset = -5;
                      } else if (subcategory["name"] == "Nails") {
                        imageSize = 80;
                      }
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (subcategory["screen"] != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => subcategory["screen"],
                                ),
                              );
                            }
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 150,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      subcategory["name"],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: bottomOffset,
                                right: rightOffset,
                                child: Image.asset(
                                  subcategory["image"],
                                  width: imageSize,
                                  height: imageSize,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
