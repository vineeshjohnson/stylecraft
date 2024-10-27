import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<InitialProductFetchEvent>((event, emit) {
      emit(
          ProductsInitialFetched(fetchProducts: fethchproduct(event.category)));
    });

    on<BrandProductFetchEvent>((event, emit) {
      emit(ProductsInitialFetched(
          fetchProducts: getProductsByBrand(event.brand)));
    });

    on<PriceProductFetchEvent>((event, emit) {
      emit(ProductsInitialFetched(
          fetchProducts: getProductsByPrice(event.price)));
    });

    on<ProductClickedEvent>((event, emit) {
      emit(ProductClickedState(productmodel: event.productModel));
    });
  }
}

Future<List<ProductModel>> fethchproduct(String category) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore
      .collection('products')
      .where('category', isEqualTo: category)
      .get();
  return querySnapshot.docs
      .map((doc) => ProductModel.fromDocument(doc))
      .toList();
}

// Assuming you have a ProductModel class

Future<List<ProductModel>> getProductsByBrand(String brandName) async {
  // Create a reference to the Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Query the products collection where the 'brand' field equals the passed brandName
  QuerySnapshot snapshot = await firestore
      .collection('products')
      .where('brand', isEqualTo: brandName)
      .get();

  // Map the query snapshot to a list of ProductModel objects
  List<ProductModel> products = snapshot.docs.map((doc) {
    return ProductModel.fromDocument(doc);
  }).toList();

  return products;
}

Future<List<ProductModel>> getProductsByPrice(String price) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore
      .collection('products')
      .where('price', isLessThanOrEqualTo: int.parse(price))
      .get();

  List<ProductModel> products = snapshot.docs.map((doc) {
    return ProductModel.fromDocument(doc);
  }).toList();

  return products;
}
