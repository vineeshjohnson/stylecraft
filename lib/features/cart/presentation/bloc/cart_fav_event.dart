// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_fav_bloc.dart';

sealed class CartFavEvent extends Equatable {
  const CartFavEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartFavEvent {}

class FetchFavEvent extends CartFavEvent {}

class CartIncrementEvent extends CartFavEvent {
  final String productId;
  final Map<String, dynamic> updatedValues;
  const CartIncrementEvent({
    required this.productId,
    required this.updatedValues,
  });
}

class CartdecrementEvent extends CartFavEvent {
  final String productId;
  final Map<String, dynamic> updatedValues;
  const CartdecrementEvent({
    required this.productId,
    required this.updatedValues,
  });
}

class RemoveFromCartEvent extends CartFavEvent {
  const RemoveFromCartEvent({required this.productId});
  final String productId;
}
