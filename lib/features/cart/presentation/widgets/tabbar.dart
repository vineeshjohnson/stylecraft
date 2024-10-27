import 'package:finalproject/features/cart/presentation/screens/cart_screen/cart_products.dart';
import 'package:flutter/material.dart';

import '../screens/fav_screen/fav_products.dart';

class FavoritesAndCartPage extends StatelessWidget {
  const FavoritesAndCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Products",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color.fromARGB(255, 33, 1, 1)],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 6.0, color: Colors.white),
              insets: EdgeInsets.symmetric(horizontal: 20.0),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.shopping_cart_outlined, size: 24),
                text: "Cart",
              ),
              Tab(
                icon: Icon(Icons.favorite_border_outlined, size: 24),
                text: "Wish List",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CartProducts(),
            FavProducts(),
          ],
        ),
      ),
    );
  }
}
