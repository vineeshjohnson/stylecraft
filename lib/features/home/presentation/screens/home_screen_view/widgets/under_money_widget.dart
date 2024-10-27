import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/products/presentation/product_screen/product_screen.dart';
import 'package:flutter/material.dart';

class UnderMoneyWidget extends StatelessWidget {
  const UnderMoneyWidget({
    super.key,
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductView(
                  price: price,
                )));
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            gradient: const LinearGradient(
              colors: [Colors.black, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          height: 140,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Under',
                style: TextStyle(fontSize: 30, fontFamily: font4),
              ),
              Text(
                '\u20B9 $price',
                style: TextStyle(fontSize: 30, fontFamily: font4),
              )
            ],
          )),
    );
  }
}
