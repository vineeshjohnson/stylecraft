import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/screens/cart_screen/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartFavBloc()..add(FetchCartEvent()),
      child: BlocConsumer<CartFavBloc, CartFavState>(
        listener: (context, state) {
          if (state is CartIncrimentedState) {
            snackBar(context, 'Cart Updated Successfully');
          }
        },
        builder: (context, state) {
          if (state is CartFetchedState) {
            if (state.productmodels.isEmpty) {
              return const SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Text(
                      'Your cart is empty!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            } else {
              return SafeArea(
                child: Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cartProducts(state),
                  ),
                  bottomNavigationBar: buttonForTotal(state),
                ),
              );
            }
          } else if (state is CartLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('No products found')),
            );
          }
        },
      ),
    );
  }
}
