part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductsInitialFetched extends ProductState {
  const ProductsInitialFetched({required this.fetchProducts});
  final Future<List<ProductModel>> fetchProducts;
}

final class ProductClickedState extends ProductState {
  final ProductModel productmodel;
  const ProductClickedState({required this.productmodel});
}
