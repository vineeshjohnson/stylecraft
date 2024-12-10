import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
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
      "$rupee ${productModel.price.toStringAsFixed(2)}",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}
