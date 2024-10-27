part of 'cart_fav_bloc.dart';

sealed class CartFavState extends Equatable {
  const CartFavState();

  @override
  List<Object> get props => [];
}

final class CartFavInitial extends CartFavState {}

final class CartFetchedState extends CartFavState {
  const CartFetchedState(
      {required this.productmodels, required this.totalprice});
  final List<ProductModel> productmodels;
  final int totalprice;
}

final class FavFetchedState extends CartFavState {
  const FavFetchedState({required this.productmodels});
  final List<ProductModel> productmodels;
}

final class CartIncrimentedState extends CartFavState {}

final class CartLoadingState extends CartFavState {}

final class FavLoadingState extends CartFavState {}
