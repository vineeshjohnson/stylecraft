import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required PageController pageController,
    required this.productModel,
  }) : _pageController = pageController;

  final PageController _pageController;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: productModel.imagepath.length,
              onPageChanged: (int index) {},
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      productModel.imagepath[index],
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
            kheight10,
            SmoothPageIndicator(
              controller: _pageController,
              count: productModel.imagepath.length,
              effect: const WormEffect(),
            ),
          ],
        ),
      ),
    );
  }
}
