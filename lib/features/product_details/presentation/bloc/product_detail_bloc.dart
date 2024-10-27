import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailsFetchEvent>((event, emit) async {
      emit(ProductDetailLoading());
      final isCart = await _isProductInCart(event.productmodel.productId!);
      final isFav = await _isProductInFavorites(event.productmodel.productId!);
      emit(ProductDetailsFetchedState(iscart: isCart, isfav: isFav));
    });

    on<AddToCartEvent>((event, emit) async {
      emit(ProductDetailLoading());
      await _handleAddToCartEvent(event.productid);
      final isCart = await _isProductInCart(event.productid);
      final isFav = await _isProductInFavorites(event.productid);

      emit(ProductAddedToCartState());
      emit(ProductDetailsFetchedState(iscart: isCart, isfav: isFav));
    });

    on<AddToFavEvent>((event, emit) async {
      emit(ProductDetailLoading());
      await _handleAddToFavEvent(event.productid);
      final isCart = await _isProductInCart(event.productid);
      final isFav = await _isProductInFavorites(event.productid);
      emit(ProductAddedToFavState());
      emit(ProductDetailsFetchedState(iscart: isCart, isfav: isFav));
    });

    on<RemoveFavEvent>((event, emit) async {
      emit(ProductDetailLoading());
      await _handleRemoveFavEvent(event.productid);
      final isCart = await _isProductInCart(event.productid);
      final isFav = await _isProductInFavorites(event.productid);
      emit(ProductDetailsFetchedState(iscart: isCart, isfav: isFav));
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if product is in the user's cart
  Future<bool> _isProductInCart(String productId) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final Map<String, dynamic> cart2 = userDoc['cart2'] ?? {};
      print(cart2);
      // Check if the productId exists as a key in the cart2 map
      return cart2.containsKey(productId);
    }
    return false;
  }

  // Check if product is in the user's favorites
  Future<bool> _isProductInFavorites(String productId) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final List<dynamic> favorites = userDoc['favorites'] ?? [];
      return favorites.contains(productId);
    }
    return false;
  }

  Future<void> _handleAddToCartEvent(String productid) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentReference userDocRef =
        _firestore.collection('users').doc(userId);

    await userDocRef.update({
      'cart2.$productid': 1,
    });
  }

  Future<void> _handleAddToFavEvent(String productid) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentReference userDocRef =
        _firestore.collection('users').doc(userId);

    await userDocRef.update({
      'favorites': FieldValue.arrayUnion([productid]),
    });
  }

  Future<void> _handleRemoveFavEvent(String productid) async {
    final String userId = _auth.currentUser!.uid;
    final DocumentReference userDocRef =
        _firestore.collection('users').doc(userId);

    // Remove the product from favorites
    await userDocRef.update({
      'favorites': FieldValue.arrayRemove([productid]),
    });
  }
}
