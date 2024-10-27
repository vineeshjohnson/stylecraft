import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: SizedBox(
          height: 80,
          width: 80,
          child: Image.network(
            product.imagepath[0],
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brand: ${product.brand}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(
              'Price: \u20B9${product.price * product.count!}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  if (product.count! <= 1) {
                    context.read<CartFavBloc>().add(
                        RemoveFromCartEvent(productId: product.productId!));
                  } else {
                    context.read<CartFavBloc>().add(CartIncrementEvent(
                            productId: product.productId!,
                            updatedValues: {
                              product.productId!: product.count! - 1
                            }));
                  }
                },
                icon:
                    const Icon(Icons.remove_circle_outline, color: Colors.red),
              ),
              Text(
                product.count?.toString() ?? '0',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  context.read<CartFavBloc>().add(CartIncrementEvent(
                      productId: product.productId!,
                      updatedValues: {product.productId!: product.count! + 1}));
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> incrementProductById(
    String productId, Map<String, dynamic> updatedValues) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    // Reference to the user's document
    DocumentReference userDocRef = firestore.collection('users').doc(userId);

    // Update the specific product count in the 'cart2' map
    await userDocRef.update({'cart2.$productId': updatedValues[productId]});

    print('Product updated successfully!');
  } catch (e) {
    print('Error updating product: $e');
  }
}
