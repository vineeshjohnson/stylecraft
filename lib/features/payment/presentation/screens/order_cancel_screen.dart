import 'dart:async';

import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderCancelScreen extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String orderTime;
  final int? walletAmount;
  final OrderModel orderdetails;

  const OrderCancelScreen({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.orderTime,
    this.walletAmount,
    required this.orderdetails,
  });

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      triggerFunction(context);
    });
  }

  void triggerFunction(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => BottomNavigationBars()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    startTimer(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Cancelled Successfully"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04), // Dynamic padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "We Cancelled Your Order Successfully",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              kheight10,
              SizedBox(
                height: size.height * 0.4, // Responsive height
                width: double.infinity,
                child: Lottie.asset(
                  'assets/images/cancel.json',
                  fit: BoxFit.contain,
                ),
              ),
              kheight10,
              (orderdetails.walletpayment! || orderdetails.onlinepayment!)
                  ? const Text(
                      "Refund Will Be Credited Soon in Your Style Craft Wallet",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
              kheight30,
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBars(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.02,
                  ), // Dynamic padding
                ),
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
