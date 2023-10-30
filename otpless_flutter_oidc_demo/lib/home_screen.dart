import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          });
        },
        child: const Text(
          "Login",
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              "Name : ",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Number : ",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
