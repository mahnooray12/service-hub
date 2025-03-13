import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servicehub/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBfXdsro0OxIXrWvYsAfenT1wctAunkmX0",
            authDomain: "service-hub-ba6e8.firebaseapp.com",
            projectId: "service-hub-ba6e8",
            storageBucket: "service-hub-ba6e8.firebasestorage.app",
            messagingSenderId: "293052777828",
            appId: "1:293052777828:web:5a9bb366f40d7e23dfa671"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(ServiceHubApp());
}

class ServiceHubApp extends StatelessWidget {
  const ServiceHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
