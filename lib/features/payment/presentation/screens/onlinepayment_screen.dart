import 'dart:convert';

import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/normal_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:finalproject/features/payment/presentation/screens/success_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class OnlinepaymentScreen extends StatelessWidget {
  const OnlinepaymentScreen(
      {super.key,
      required this.count,
      required this.totalamount,
      required this.model,
      required this.size,
      required this.address});
  final int count;
  final int totalamount;
  final ProductModel model;
  final String size;
  final List<String> address;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? intentPaymentData;
    bool isloading = false;

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

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is OnlinePaymentInitiatedState) {
            isloading = true;
          } else if (state is WalletPurchasedState) {
            Navigator.of(context).pushAndRemoveUntil(
                (MaterialPageRoute(
                    builder: (context) => OrderSuccessPage(
                          orderId: state.orderId,
                          orderDate: state.orderDate,
                          orderTime: state.orderTime,
                        ))),
                (route) => false);
          } else if (state is OnlinePaymentCancelState) {
            isloading = false;
            snackBar(context, 'Payment Cancelled');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text('Online Payment'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Lottie.asset("assets/images/online.json",
                      width: double.infinity, height: 300),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Lottie.asset(
                                'assets/images/securepayment.json')),
                        Container(
                          width: 300,
                          child: Text(
                            'Your payment is 100% secure with our trusted payment gateway.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child:
                                Lottie.asset('assets/images/fastpayment.json')),
                        Container(
                          width: 300,
                          child: Text(
                            'Fast and seamless payments to save your valuable time.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Lottie.asset('assets/images/reliable.json')),
                        Container(
                          width: 300,
                          child: Text(
                            'Trusted by thousands of customers for secure and smooth transactions.',
                            style: TextStyle(fontFamily: font5, fontSize: 16),
                          ),
                        ),
                        kheight30,
                      ],
                    ),
                  ),
                  kheight30,
                  NormalButton(
                    onTap: () {
                      context.read<PaymentBloc>().add(PaymentThroughOnlineEvent(
                          count, model.productId!, size, address,
                          amount: totalamount));
                    },
                    buttonTxt: 'Pay $rupee $totalamount',
                    color: Colors.green.shade800,
                    widgets: isloading ? CircularProgressIndicator() : null,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
