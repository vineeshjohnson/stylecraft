import 'package:finalproject/core/models/product_model.dart';
import 'package:flutter/material.dart';

class StockWidget extends StatelessWidget {
  const StockWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          productModel.available ? Icons.check_circle : Icons.cancel,
          color: productModel.available ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          productModel.available ? "In Stock" : "Out of Stock",
          style: TextStyle(
            fontSize: 16,
            color: productModel.available ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
