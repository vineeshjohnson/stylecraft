import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/widgets/cart_widget.dart';
import 'package:finalproject/features/order/presentation/screens/orderwith_address_for_cart.dart';
import 'package:flutter/material.dart';

BottomAppBar buttonForTotal(
    CartFetchedState state, BuildContext context, List<ProductModel> list) {
  return BottomAppBar(
    color: Colors.black,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Total Amount',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '\u20B9 ${state.totalprice.toString()}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderwithAddressForCart(products: list)));
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
            backgroundColor: Colors.orange,
          ),
          child: const Text(
            'Check Out',
            style: TextStyle(fontSize: 20),
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
