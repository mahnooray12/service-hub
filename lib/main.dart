import 'package:flutter/material.dart';
import 'package:servicehub/splash.dart';

void main() {
  runApp(ServiceHubApp());
}

class ServiceHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
