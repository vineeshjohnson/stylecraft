part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class InitialProductFetchEvent extends ProductEvent {
  final String category;
  const InitialProductFetchEvent({required this.category});
}

class BrandProductFetchEvent extends ProductEvent {
  final String brand;
  const BrandProductFetchEvent({required this.brand});
}

class ProductSearchEvent extends ProductEvent {
  final String searchQuery;
  const ProductSearchEvent({required this.searchQuery});
}

class PriceProductFetchEvent extends ProductEvent {
  final String price;
  const PriceProductFetchEvent({required this.price});
}

class ProductClickedEvent extends ProductEvent {
  final ProductModel productModel;
  const ProductClickedEvent({required this.productModel});
}
