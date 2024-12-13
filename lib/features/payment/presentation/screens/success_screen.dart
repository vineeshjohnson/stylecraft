import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String orderTime;
  final int? walletAmount;

  const OrderSuccessPage({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.orderTime,
    this.walletAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Successful"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Thank you for your order!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Lottie.asset('assets/images/orderplaced.json'),
              ),
              kheight40,
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Your Order Placed Successfully Track Your Order For More Info",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Text(
                "Date: $orderDate",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Text(
                "Time: $orderTime",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Text(
                "Order ID: $orderId",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text(
                walletAmount != null ? "Wallet Balance: ₹$walletAmount" : '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
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
