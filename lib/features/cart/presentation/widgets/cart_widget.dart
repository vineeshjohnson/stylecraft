import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) async {
        bool confirm = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Remove Item'),
            content: const Text('Are you sure you want to remove this item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Remove'),
              ),
            ],
          ),
        );

        if (confirm) {
          context
              .read<CartFavBloc>()
              .add(RemoveFromCartEvent(productId: product.productId!));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.network(
                product.imagepath[0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          title: Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brand: ${product.brand}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  'Price: ₹${product.price * product.count!}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      if (product.count! <= 1) {
                        context.read<CartFavBloc>().add(
                            RemoveFromCartEvent(productId: product.productId!));
                      } else {
                        context.read<CartFavBloc>().add(CartIncrementEvent(
                              productId: product.productId!,
                              updatedValues: [
                                product.selectedsize,
                                product.count! - 1
                              ],
                            ));
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    product.count?.toString() ?? '0',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<CartFavBloc>().add(CartIncrementEvent(
                            productId: product.productId!,
                            updatedValues: [
                              product.selectedsize,
                              product.count! + 1
                            ],
                          ));
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
