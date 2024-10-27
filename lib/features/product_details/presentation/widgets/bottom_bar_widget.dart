import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppbarWidget extends StatelessWidget {
  const BottomAppbarWidget(
      {super.key, required this.productModel, required this.state});

  final ProductModel productModel;
  final ProductDetailsFetchedState state;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<ProductDetailBloc>()
                    .add(AddToCartEvent(productid: productModel.productId!));
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Colors.orange,
              ),
              child: state.iscart
                  ? const Text(
                      'Go to Cart',
                      style: TextStyle(fontSize: 16),
                    )
                  : const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
