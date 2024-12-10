part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailsFetchEvent extends ProductDetailEvent {
  const ProductDetailsFetchEvent({required this.productmodel});
  final ProductModel productmodel;
}

class AddToCartEvent extends ProductDetailEvent {
  const AddToCartEvent({required this.productid,required this.size});
  final String productid;
  final String size;
}

class AddToFavEvent extends ProductDetailEvent {
  const AddToFavEvent({required this.productid});
  final String productid;
}

class RemoveFavEvent extends ProductDetailEvent {
  const RemoveFavEvent({required this.productid});
  final String productid;
}
