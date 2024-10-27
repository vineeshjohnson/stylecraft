import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              )),
          Container(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'NewAmsterdam'),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 40,
              ))
        ],
      ),
    );
  }
}
