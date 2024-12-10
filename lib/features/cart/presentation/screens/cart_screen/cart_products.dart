import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/screens/cart_screen/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ProductModel> cartproducts = [];
    return BlocProvider(
      create: (context) => CartFavBloc()..add(FetchCartEvent()),
      child: BlocConsumer<CartFavBloc, CartFavState>(
        listener: (context, state) {
          if (state is CartIncrimentedState) {
            snackBar(context, 'Cart Updated Successfully');
          } else if (state is CartFetchedState) {
            cartproducts = state.productmodels;
          }
        },
        builder: (context, state) {
          if (state is CartFetchedState) {
            if (state.productmodels.isEmpty) {
              return const SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            } else {
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cartProducts(state),
                  ),
                  bottomNavigationBar:
                      buttonForTotal(state, context, cartproducts),
                ),
              );
            }
          } else if (state is CartLoadingState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Lottie.asset("assets/images/loading.json",
                    width: double.infinity, height: 300),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                  child: Text(
                'No products found',
                style: TextStyle(color: Colors.white),
              )),
            );
          }
        },
      ),
    );
  }
}
