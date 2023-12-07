import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeRepository {
  final String clientId = "EN99SOJPZNXUHH5ILM3ZPR6D1VULJSH2";
  final String clientSecret = "ifllg6fk6ea46t71zpe1y10eavmz5chb";
  final String redirectUri = "dev://otpless";

  ///This api will send the verification link on given number on whatsapp and same goes for emal
  Future callMagicLink(String mobileNumber) async {
    print(mobileNumber);

    try {
      // Make GET request
      final response = await http.get(
        Uri.parse(
            "https://auth.otpless.app/auth/v1/authorize?client_id=$clientId&client_secret=$clientSecret&mobile_number=$mobileNumber&redirect_uri=$redirectUri"),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and print the response body
        print('Response: ${json.decode(response.body)}');
      } else {
        // If the request did not succeed, print the error code and message
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
  }

  ///This api is used for fetching [user data] using [access_token]

  Future<String?> callFetchData(String accessToken) async {
    print(accessToken);

    try {
      // Make GET request
      final response = await http.post(
        Uri.parse("https://user-auth.otpless.app/auth/v1/userinfo"),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and print the response body
        print('Response: ${json.decode(response.body)}');
        return json.decode(response.body)["phone_number"];
      } else {
        // If the request did not succeed, print the error code and message
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
    return null;
  }

  ///This api is used to create a session of the user [access_token, id_token]
  Future<String?> callTokenRetrieval(String code) async {
    print(code);

    Map<String, dynamic> requestBody = {
      "grant_type": "code",
      "code": code,
      "client_id": clientId,
      "client_secret": clientSecret
    };

    try {
      // Convert the request body to JSON
      String jsonBody = json.encode(requestBody);
      // Make GET request
      final response = await http.post(
          Uri.parse("https://user-auth.otpless.app/auth/v1/token"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonBody);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and print the response body
        print('Response: ${json.decode(response.body)}');

        return json.decode(response.body)["access_token"];
      } else {
        // If the request did not succeed, print the error code and message
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
    return null;
  }
}
