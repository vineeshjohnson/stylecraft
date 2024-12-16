import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/products/presentation/product_screen/bloc/product_bloc.dart';

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
        print('Product clicked');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Discount Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: FadeInImage.assetNetwork(
                      placeholder:
                          'assets/images/loadings.jpg', // Path to your placeholder image
                      image: product.imagepath[0],
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/placeholder.png', // Fallback image in case of error
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (product.offeritem == true)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Save ${product.discountpercent.toString()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand Name
                  Text(
                    product.brand,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Product Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),

                  // Price Information
                  Row(
                    children: [
                      Text(
                        '\u20B9${product.price + ((product.price * product.discountpercent!) / 100)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '\u20B9${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Delivery Info
                  const Text(
                    'Free Delivery',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
