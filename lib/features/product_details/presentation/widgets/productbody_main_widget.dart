import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/features/cart/presentation/screens/cart_screen/functions.dart';
import 'package:finalproject/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:finalproject/features/product_details/presentation/widgets/fav_button_widget.dart';
import 'package:finalproject/features/product_details/presentation/widgets/price_widget.dart';
import 'package:finalproject/features/product_details/presentation/widgets/product_image_widget.dart';
import 'package:finalproject/features/product_details/presentation/widgets/productname_widget.dart';
import 'package:finalproject/features/product_details/presentation/widgets/shipping_widget.dart';
import 'package:finalproject/features/product_details/presentation/widgets/stock_widget.dart';
import 'package:flutter/material.dart';

class ProductBody extends StatelessWidget {
  const ProductBody(
      {super.key,
      required this.productModel,
      required PageController pageController,
      required this.state})
      : _pageController = pageController;

  final ProductModel productModel;
  final PageController _pageController;
  final ProductDetailsFetchedState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductNameWidget(productModel: productModel),
            FavButtonWidget(
              productModel: productModel,
              state: ProductDetailsFetchedState(
                  iscart: state.iscart, isfav: state.isfav),
            )
          ],
        ),
        kheight10,
        PriceWidget(productModel: productModel),
        kheight20,
        ProductImageWidget(
            pageController: _pageController, productModel: productModel),
        kheight20,
        const Text(
          "About Product",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kheight10,
        Text(
          productModel.description,
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              fontFamily: 'AfacadFlux-SemiBold'),
        ),
        kheight20,
        const Text(
          "Brand",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kheight10,
        Text(
          productModel.brand,
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
              fontFamily: 'AfacadFlux-SemiBold'),
        ),
        kheight20,
        const Text(
          "Available Sizes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kheight10,
        Wrap(
          spacing: 10.0,
          children: getAvailableSizes(productModel),
        ),
        kheight20,
        StockWidget(productModel: productModel),
        kheight10,
        const ShippingWidget(),
        kheight20,
      ],
    );
  }
}
