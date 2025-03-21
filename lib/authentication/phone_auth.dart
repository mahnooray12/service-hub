import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/authentication/otp.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  // Function to validate phone number and send OTP
  void sendOTP() async {
    String phoneNumber = phoneController.text.trim();

    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      Get.snackbar("Invalid Input", "Enter a valid phone number",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.snackbar("Success", "Logged in automatically",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Something went wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.snackbar("OTP Sent", "Check your phone for the OTP",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          Get.to(
            OTPScreen(verificationId: verificationId, phoneNumber: phoneNumber),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1E5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at the top
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.asset('assets/phoneAuth.jpg', fit: BoxFit.contain),
            ),

            // Login form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login with Phone",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    const SizedBox(height: 15),

                    // Phone Number Field
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.brown),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Send OTP Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: isLoading ? null : sendOTP,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Send OTP',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
    );
  }
}
