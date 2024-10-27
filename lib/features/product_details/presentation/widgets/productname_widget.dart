import 'package:finalproject/core/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductNameWidget extends StatelessWidget {
  const ProductNameWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Text(
        productModel.name,
        style: const TextStyle(
            fontFamily: 'Montserrat-Black',
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
