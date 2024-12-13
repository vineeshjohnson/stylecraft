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
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.black,
          title: const Text(
            'Your Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.hourglass_empty, size: 24),
                text: "Ongoing",
              ),
              Tab(
                icon: Icon(Icons.done_all, size: 24),
                text: "Completed",
              ),
              Tab(
                icon: Icon(Icons.cancel, size: 24),
                text: "Cancelled",
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
