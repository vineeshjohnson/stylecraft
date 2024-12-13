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
          color:
              Colors.grey.shade900, // Slightly lighter than black for contrast
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: const EdgeInsets.all(8.0), // Margin for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product brand and name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: const TextStyle(
                      color: Colors.blueAccent, // Highlight brand name
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white, // Product name color
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Image in the center
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loadings.jpg',
                    image: product.imagepath[0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Price section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u20B9${product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    'MRP: \u20B9${product.price + 200}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
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
