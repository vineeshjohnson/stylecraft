import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/cart/presentation/screens/cart_screen/functions.dart';
import 'package:finalproject/features/order/presentation/screens/order_with_address.dart';
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
              onPressed: () {
                var sizes = getsizelist(productModel);
                showBottomSheet(
                    sheetAnimationStyle:
                        AnimationStyle(duration: const Duration(seconds: 1)),
                    context: context,
                    builder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.grey),
                            height: 150,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Select A Size',
                                  style: addressstyle,
                                ),
                                kheight20,
                                Expanded(
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderWithAddress(
                                                            size: sizes[index],
                                                            product:
                                                                productModel,
                                                          )));
                                            },
                                            child: sizeChip(sizes[index])),
                                    itemCount: sizes.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => OrderWithAddress(
                //           product: productModel,
                //         )));
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
}

List<String> getsizelist(ProductModel model) {
  List<String> sizes = [];
  if (model.small) sizes.add("Small");
  if (model.medium) sizes.add("medium");
  if (model.large) sizes.add("large");
  if (model.xl) sizes.add("xl");
  if (model.xxl) sizes.add("xxl");
  return sizes;
}
