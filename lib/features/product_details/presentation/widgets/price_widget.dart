import 'package:finalproject/core/models/product_model.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$${productModel.price.toStringAsFixed(2)}",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}
