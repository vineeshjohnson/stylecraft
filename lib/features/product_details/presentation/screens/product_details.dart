import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';

import 'package:finalproject/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:finalproject/features/product_details/presentation/widgets/bottom_bar_widget.dart';

import 'package:finalproject/features/product_details/presentation/widgets/productbody_main_widget.dart';

import 'package:flutter/material.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel productModel;

  ProductDetails({super.key, required this.productModel});

  final TextEditingController searchcontroller = TextEditingController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc()
        ..add(ProductDetailsFetchEvent(productmodel: productModel)),
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state is ProductAddedToCartState) {
            snackBar(context, 'Product added to cart successfully');
          } else if (state is ProductAddedToFavState) {
            snackBar(context, 'Product added as Favourite successfully');
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsFetchedState) {
            return Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBarWidget(
                  title: 'Products',
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProductBody(
                    productModel: productModel,
                    pageController: _pageController,
                    state: ProductDetailsFetchedState(
                        iscart: state.iscart, isfav: state.isfav),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppbarWidget(
                productModel: productModel,
                state: ProductDetailsFetchedState(
                    iscart: state.iscart, isfav: state.isfav),
              ),
            );
          } else {
            return const Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBarWidget(title: 'Products'),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
