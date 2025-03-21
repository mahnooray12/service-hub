import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:servicehub/authentication/wrapper.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPScreen(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;
  late String verificationId;

  @override
  void initState() {
    super.initState();
    verificationId = widget.verificationId;
  }

  void verifyOTP() async {
    if (_otpController.text.length != 6) {
      Get.snackbar("Invalid OTP", "Enter a valid 6-digit OTP",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text.trim(),
      );
      await _auth.signInWithCredential(credential);
      Get.offAll(Wrapper());
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP. Try again.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Verify OTP"),
          centerTitle: true,
          backgroundColor: Colors.brown),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.image,
                    size: 50, color: Colors.grey), // Placeholder for image
              ),
            ),
            const SizedBox(height: 20),
            Text("Enter the OTP sent to ${widget.phoneNumber}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Pinput(
              controller: _otpController,
              length: 6,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _otpController.text = value;
                });
              },
              defaultPinTheme: PinTheme(
                width: 50,
                height: 50,
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.all(14)),
                onPressed: isLoading ? null : verifyOTP,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Verify OTP",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
