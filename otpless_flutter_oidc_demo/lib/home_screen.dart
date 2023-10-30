import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name = '';
  String? number = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          OAuthProvider provider = OAuthProvider("oidc.testing");
          await FirebaseAuth.instance
              .signInWithProvider(provider)
              .then((value) {
            log(value.additionalUserInfo.toString());
            if (value.additionalUserInfo != null) {
              name = value.additionalUserInfo!.profile!['name'];
              number = value.additionalUserInfo!.profile!['phone_number'];
              setState(() {});
            }
          });
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
