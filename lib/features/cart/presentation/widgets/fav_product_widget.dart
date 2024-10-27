import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/product_details/presentation/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlternativeProductWidget extends StatelessWidget {
  const AlternativeProductWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                      productModel: product,
                    )))
            .then((_) {
          context.read<CartFavBloc>().add(FetchFavEvent());
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent), // Border styling
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        height: 100, // Height of the widget
        width: 50, // Width of the widget
        margin: const EdgeInsets.all(8.0), // Margin for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product brand and name at the top
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: const TextStyle(
                      color: Colors.blue, // Brand color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.black54, // Name color
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Image in the center
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Image rounded corners
                  child: Image.network(
                    product.imagepath[0],
                    fit: BoxFit.cover, // Image fit style
                    width: double.infinity, // Image takes full width
                  ),
                ),
              ),
            ),

            // Price section at the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u20B9${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'MRP: \u20B9${product.price + 200}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Padding at the bottom for spacing
          ],
        ),
      ),
    );
  }
}
