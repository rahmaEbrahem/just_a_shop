import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> initiatePaymobPayment({
  required double amount, 
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
}) async {
  final url = Uri.parse('https://paymob-mock-backend.vercel.app/api/create-payment');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': amount, 
        'firstName': firstName, 
        'lastName': lastName, 
        'email': email, 
        'phone': phone, 
      }),
    );

    final data = jsonDecode(response.body);

    if (data['success'] == true) {
      String paymentKey = data['payment_key'];
      
      String paymentUrl = "https://accept.paymob.com/api/acceptance/iframes/1093635?payment_token=$paymentKey";
      
      final Uri uri = Uri.parse(paymentUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print("Could not launch $paymentUrl");
      }
      
    } else {
      print("Error: ${data['message']}");
    }
  } catch (e) {
    print("Network Error: $e");
  }
}