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

  const OrderCancelScreen(
      {super.key,
      required this.orderId,
      required this.orderDate,
      required this.orderTime,
      this.walletAmount,
      required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Cancelled Successful"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                "We Cancelled Your order Successfully",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              kheight10,
              SizedBox(
                height: 350,
                width: double.infinity,
                child:
                    Lottie.asset('assets/images/cancel.json', fit: BoxFit.fill),
              ),
              kheight10,
              const SizedBox(height: 20),
              kheight20,
              (orderdetails.walletpayment! || orderdetails.onlinepayment!)
                  ? const Text(
                      "Refund Will be credit soon in your Style Craft Wallet",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : kheight10,
              kheight30,
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const BottomNavigationBars()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/orders');
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  "View Details",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
