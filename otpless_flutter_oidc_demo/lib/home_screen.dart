import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepPurpleAccent,
                content: SizedBox(
                  height: 60,
                  child: Text(
                    value.additionalUserInfo!.username!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
            setState(() {});
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
