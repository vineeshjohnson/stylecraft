import 'package:finalproject/core/usecases/strings/strings.dart';
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
          title: Text(
            "My Products",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: font4),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 5,
          bottom: const TabBar(
            indicator: BoxDecoration(),
            padding: EdgeInsets.all(5),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
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
                icon: Icon(
                  Icons.shopping_cart,
                  size: 50,
                  color: Colors.green,
                ),
                text: "Cart",
              ),
              Tab(
                icon: Icon(
                  Icons.favorite,
                  size: 50,
                  color: Colors.red,
                ),
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
