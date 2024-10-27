part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class CategoryInitialFetchingState extends HomeState {
  const CategoryInitialFetchingState(
      {required this.categorymodel,
      required this.username,
      required this.image,
      required this.brands});
  final Future<List<CategoryModel>> categorymodel;
  final String username;
  final String image;
  final List<String> brands;
}

class ProductInitialFetchingState extends HomeState {
  const ProductInitialFetchingState({required this.productmodel});
  final Future<List<ProductModel>> productmodel;
}
