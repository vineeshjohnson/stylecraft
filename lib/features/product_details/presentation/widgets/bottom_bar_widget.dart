import 'package:finalproject/features/cart/presentation/widgets/tabbar.dart';
import 'package:finalproject/features/product_details/presentation/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/order/presentation/screens/order_with_address.dart';

import '../bloc/product_detail_bloc.dart';

class BottomAppbarWidget extends StatelessWidget {
  const BottomAppbarWidget({
    super.key,
    required this.productModel,
    required this.state,
    required this.bloc,
  });

  final ProductModel productModel;
  final ProductDetailsFetchedState state;
  final ProductDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: state.iscart
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavoritesAndCartPage()));
                    }
                  : () {
                      var sizes = getsizelist(productModel);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => _buildSizeSelectorSheet(
                          context: context,
                          sizes: sizes,
                          onSizeSelected: (selectedSize) {
                            bloc.add(AddToCartEvent(
                              productid: productModel.productId!,
                              size: selectedSize,
                            ));
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                        productModel: productModel)));
                          },
                        ),
                      ).then((_) {
                        // Trigger the event when the bottom sheet is dismissed
                        bloc.add(ProductDetailsFetchEvent(
                            productmodel: productModel));
                      });
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
              onPressed: () {
                var sizes = getsizelist(productModel);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => _buildSizeSelectorSheet(
                    context: context,
                    sizes: sizes,
                    onSizeSelected: (selectedSize) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderWithAddress(
                            size: selectedSize,
                            product: productModel,
                          ),
                        ),
                      );
                    },
                  ),
                ).then((_) {
                  // Trigger the event when the bottom sheet is dismissed
                  bloc.add(
                      ProductDetailsFetchEvent(productmodel: productModel));
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelectorSheet({
    required BuildContext context,
    required List<String> sizes,
    required Function(String selectedSize) onSizeSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select a Size',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            itemCount: sizes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => onSizeSelected(sizes[index]),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade300,
                    width: 1,
                  ),
                ),
                child: Text(
                  sizes[index],
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> getsizelist(ProductModel model) {
  List<String> sizes = [];
  if (model.small) sizes.add("Small");
  if (model.medium) sizes.add("Medium");
  if (model.large) sizes.add("Large");
  if (model.xl) sizes.add("XL");
  if (model.xxl) sizes.add("XXL");
  return sizes;
}
