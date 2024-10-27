import 'package:flutter/material.dart';

class BrandBanner extends StatelessWidget {
  const BrandBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(color: Colors.black),
      child: Row(
        children: [
          const SizedBox(
            width: 3,
          ),
          Container(
            width: 80,
            height: 80,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/adidas.png',
                      width: 35,
                      height: 35,
                    ),
                    Image.asset(
                      'assets/images/puma.png',
                      width: 35,
                      height: 35,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/nike.png',
                      width: 35,
                      height: 35,
                    ),
                    Image.asset(
                      'assets/images/jordan.png',
                      width: 35,
                      height: 35,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 19),
            child: Column(
              children: [
                Text(
                  'Explore Your Favourite Brands',
                  style: TextStyle(
                      fontFamily: 'LondrinaSketch-Regular',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'With Style Craft',
                  style: TextStyle(
                      fontFamily: 'LondrinaSketch-Regular',
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
