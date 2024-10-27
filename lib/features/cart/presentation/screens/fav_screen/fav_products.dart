import 'package:finalproject/features/cart/presentation/bloc/cart_fav_bloc.dart';
import 'package:finalproject/features/cart/presentation/widgets/fav_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is FavFetchedState) {
            if (state.productmodels.isEmpty) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'Your Wish List is empty!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              return SafeArea(
                child: Scaffold(
                    body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            itemCount: state.productmodels.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.6,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5),
                            itemBuilder: (BuildContext context, int index) =>
                                AlternativeProductWidget(
                                  product: state.productmodels[index],
                                )))),
              );
            }
          } else {
            return const Scaffold(
                body: Center(child: Text('no products found')));
          }
        },
      ),
    );
  }
}
