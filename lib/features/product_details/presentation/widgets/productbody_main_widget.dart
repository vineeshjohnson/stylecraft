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
        kheight10,
        // Discount Section inside Elevated Container
        Row(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.discount,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${productModel.discountpercent}% OFF", 
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
