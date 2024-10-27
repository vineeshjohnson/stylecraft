part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsFetchedState extends ProductDetailState {
  const ProductDetailsFetchedState({required this.iscart, required this.isfav});
  final bool iscart;
  final bool isfav;
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductAddedToCartState extends ProductDetailState {}

final class ProductAddedToFavState extends ProductDetailState {}
