import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otpless_flutter_magic_link_demo/home_repository.dart';
import 'package:uni_links/uni_links.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? number;

  TextEditingController phoneNumberController = TextEditingController();

  ///uni_links are used to fetch the deeplink which contains the code in queryparametes
  StreamSubscription? sub;

  Future<void> initUniLinks() async {
    sub = linkStream.listen((String? link) async {
      Uri uri = Uri.parse(link!);

      // Get the query parameters as a map
      Map<String, dynamic> queryParams = uri.queryParameters;

      // Get the value of the 'code' parameter
      String codeValue = queryParams['code'];

      print("OTPLESS code : $codeValue");
      final accessToken = await HomeRepository().callTokenRetrieval(codeValue);
      number = await HomeRepository().callFetchData(accessToken!);
      setState(() {});
    }, onError: (err) {});
  }

  @override
  void initState() {
    initUniLinks();
    super.initState();
  }

  @override
  void dispose() {
    sub!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ///Edit country code as per your country
          final mobileNumber = "91${phoneNumberController.text}";
          HomeRepository().callMagicLink(mobileNumber);
        },
        child: const Text(
          "Login",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Number : $number",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                onChanged: (value) {},
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  prefixIcon: Icon(Icons.phone, size: 18),
                  labelText: 'Phone number',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
