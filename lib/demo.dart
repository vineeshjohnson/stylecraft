import 'dart:convert';

import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double amount = 600;
  Map<String, dynamic>? intentPaymentData;

  showPaymentSheet() async {
    try {
      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // If no exception occurs, the payment is successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful")),
      );

      // Clear the intentPaymentData after successful payment
      intentPaymentData = null;
    } on StripeException catch (error) {
      // Handle Stripe-specific exceptions
      if (kDebugMode) {
        print("StripeException: $error");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Canceled")),
      );
    } catch (err) {
      // Handle general exceptions
      if (kDebugMode) {
        print("Error: $err");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed: $err")),
      );
    }
  }

  makeIntentForPayment(amountToBeCharge, currency) async {
    try {
      Map<String, dynamic>? paymentInfo = {
        "amount": (int.parse(amountToBeCharge) * 100).toString(),
        "currency": currency,
        "payment_method_types[]": "card"
      };

      var responseFromStripeAPI = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers: {
            "Authorization": "Bearer $secretkey",
            "Content-Type": "application/X-www-form-urlencoded"
          });

      print("response from API =" + responseFromStripeAPI.body);
      return jsonDecode(responseFromStripeAPI.body);
    } catch (errrorMsg) {
      if (kDebugMode) {
        print(errrorMsg);
      } else {
        print(errrorMsg.toString());
      }
    }
  }

  paymentSheetInitilization(amountToBeCharge, currency) async {
    try {
      intentPaymentData =
          await makeIntentForPayment(amountToBeCharge, currency);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  allowsDelayedPaymentMethods: true,
                  paymentIntentClientSecret:
                      intentPaymentData!["client_secret"],
                  style: ThemeMode.dark,
                  merchantDisplayName: "Style Craft"))
          .then((val) {
        print(val);
        print('fvgwduygfuydfgu8ygsdfygsdyuf');
      });

      showPaymentSheet();
    } catch (errrorMsg, s) {
      if (kDebugMode) {
        print(s);
      } else {
        print(errrorMsg.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NormalButton(
          onTap: () {
            paymentSheetInitilization(amount.round().toString(), 'INR');
          },
          buttonTxt: "pay",
          color: Colors.greenAccent.shade700,
        ),
      ),
    );
  }
}
