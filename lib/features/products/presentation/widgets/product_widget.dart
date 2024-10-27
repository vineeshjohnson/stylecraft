import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/products/presentation/product_screen/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ProductBloc>()
            .add(ProductClickedEvent(productModel: product));
        print('product clicked');
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: 500,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                product.imagepath[0],
                fit: BoxFit.fill,
              ),
            ),
            const Text(
              'Sponsored',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              product.brand,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(product.name),
            Row(
              children: [
                Text(
                  'Price: \u20B9${product.price + 200}',
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '\u20B9${product.price}',
                ),
              ],
            ),
            // Text('Free Delivery')
          ],
        ),
      ),
    );
  }
}
