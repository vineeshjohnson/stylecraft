import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/widgets/cart_widget.dart';
import 'package:finalproject/features/order/presentation/screens/order_with_address.dart';
import 'package:finalproject/features/order/presentation/screens/orderwith_address_for_cart.dart';
import 'package:flutter/material.dart';

BottomAppBar buttonForTotal(
    CartFetchedState state, BuildContext context, List<ProductModel> list) {
  return BottomAppBar(
    color: Colors.black,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 90,
            width: 180,
            color: Colors.blueAccent,
            child: Center(
                child: Text(
              'Total Amount \u20B9 ${state.totalprice.toString()}',
              style: const TextStyle(fontSize: 16),
            )),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderwithAddressForCart(products: list)));
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: Colors.orange,
            ),
            child: const Text(
              'Check Out',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}

ListView cartProducts(CartFetchedState state) {
  return ListView.separated(
    itemCount: state.productmodels.length,
    itemBuilder: (BuildContext context, int index) {
      return CartListTile(
        product: state.productmodels[index],
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return kheight10;
    },
  );
}

List<Widget> getAvailableSizes(ProductModel productModel) {
  List<Widget> sizes = [];
  if (productModel.small) sizes.add(sizeChip("Small"));
  if (productModel.medium) sizes.add(sizeChip("Medium"));
  if (productModel.large) sizes.add(sizeChip("Large"));
  if (productModel.xl) sizes.add(sizeChip("XL"));
  if (productModel.xxl) sizes.add(sizeChip("XXL"));
  return sizes;
}

Widget sizeChip(String size) {
  return Chip(
    label: Text(size),
    backgroundColor: Colors.blue.shade100,
  );
}
