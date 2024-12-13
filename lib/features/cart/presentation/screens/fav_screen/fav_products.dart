import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/widgets/fav_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavProducts extends StatelessWidget {
  const FavProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartFavBloc()..add(FetchFavEvent()),
      child: BlocConsumer<CartFavBloc, CartFavState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavLoadingState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Lottie.asset(
                  "assets/images/loading.json",
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            );
          } else if (state is FavFetchedState) {
            if (state.productmodels.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Text(
                    'Your Wish List is Empty!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                    child: GridView.builder(
                      itemCount: state.productmodels.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return AlternativeProductWidget(
                          product: state.productmodels[index],
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              body: const Center(
                child: Text(
                  'No Products Found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
