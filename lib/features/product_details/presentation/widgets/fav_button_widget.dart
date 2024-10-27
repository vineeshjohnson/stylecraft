import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/product_details/presentation/bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavButtonWidget extends StatelessWidget {
  const FavButtonWidget(
      {super.key, required this.productModel, required this.state});

  final ProductModel productModel;
  final ProductDetailsFetchedState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        state.isfav
            ? context
                .read<ProductDetailBloc>()
                .add(RemoveFavEvent(productid: productModel.productId!))
            : context
                .read<ProductDetailBloc>()
                .add(AddToFavEvent(productid: productModel.productId!));
      },
      child: Icon(
        state.isfav ? Icons.favorite : Icons.favorite_border,
        size: 50,
        color: state.isfav ? Colors.red : Colors.grey,
      ),
    );
  }
}
