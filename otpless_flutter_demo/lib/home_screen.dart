import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? number;

  //Define the instance
  final _otplessFlutterPlugin = Otpless();

  @override
  void initState() {
    super.initState();

    //************************************************************************* */
    //This function will tell if WhatsApp is Installed or not
    //************************************************************************* */

    _otplessFlutterPlugin.isWhatsAppInstalled().then(
      (value) {
        if (!value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Please install the whatsapp"),
              backgroundColor: Theme.of(context).hoverColor,
            ),
          );
        }
      },
    );
  }

  //************************************************************************* */
  //This function will run the floater in the app which contains the WhatsApp button for Authentication
  //************************************************************************* */

  Future<void> startOtpless() async {
    await _otplessFlutterPlugin.hideFabButton();
    _otplessFlutterPlugin.openLoginPage((result) {
      name = result['data']['mobile']['name'];
      number = result['data']['mobile']['number'];
      setState(() {});
      if (result['data'] != null) {
        // todo send this token to your backend service to validate otplessUser details received in the callback with OTPless backend service
        final token = result['data']['token'];
        log("Token : $token");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startOtpless();
        },
        child: const Text(
          "Login",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Name : $name",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Number : $number",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
