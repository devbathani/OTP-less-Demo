import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  final _otplessFlutterPlugin = Otpless();

  @override
  void initState() {
    super.initState();
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

  Future<void> startOtpless() async {
    await _otplessFlutterPlugin.hideFabButton();
    _otplessFlutterPlugin.start((result) {
      name = result['data']['mobile']['name'];
      setState(() {});
      if (result['data'] != null) {
// todo send this token to your backend service to validate otplessUser details received in the callback with OTPless backend service
        // final token = result['data']['token'];
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
        child: Text(
          "Name : $name",
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
