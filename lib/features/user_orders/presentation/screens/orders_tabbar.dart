import 'package:finalproject/features/user_orders/presentation/screens/cancelled_orders.dart';
import 'package:finalproject/features/user_orders/presentation/screens/completed_orders.dart';
import 'package:finalproject/features/user_orders/presentation/screens/pending_orders.dart';
import 'package:flutter/material.dart';

class UserOrdersPage extends StatelessWidget {
  const UserOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order History",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 5,
          bottom: const TabBar(
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Tab(
                  icon: Icon(Icons.hourglass_empty, size: 24),
                  text: "Ongoing",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Tab(
                  icon: Icon(Icons.done_all, size: 24),
                  text: "Completed",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Tab(
                  icon: Icon(Icons.cancel, size: 24),
                  text: "Cancelled",
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PendingOrders(),
            CompletedOrders(),
            CancelledOrders(),
          ],
        ),
      ),
    );
  }
}
