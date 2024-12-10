import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cart_fav_event.dart';
part 'cart_fav_state.dart';

class CartFavBloc extends Bloc<CartFavEvent, CartFavState> {
  CartFavBloc() : super(CartFavInitial()) {
    on<CartFavEvent>((event, emit) {});

    on<FetchCartEvent>((event, emit) async {
      emit(CartLoadingState());
      List<ProductModel> products = await fetchCartProducts();
      print(products);
      var amount = totalPrice(products);
      emit(CartFetchedState(productmodels: products, totalprice: amount));
    });

    on<FetchFavEvent>((event, emit) async {
      emit(FavLoadingState());
      List<ProductModel> products = await fetchFavProducts();
      emit(FavFetchedState(productmodels: products));
    });

    on<CartIncrementEvent>((event, emit) async {
      await incrementProductById(event.productId, event.updatedValues);
      emit(CartIncrimentedState());
      emit(CartLoadingState());

      List<ProductModel> products = await fetchCartProducts();

      var amount = totalPrice(products);
      emit(CartFetchedState(productmodels: products, totalprice: amount));
    });

    on<CartdecrementEvent>((event, emit) async {
      await decrementProductById(event.productId, event.updatedValues);
      emit(CartIncrimentedState());
      emit(CartLoadingState());

      List<ProductModel> products = await fetchCartProducts();

      var amount = totalPrice(products);
      emit(CartFetchedState(productmodels: products, totalprice: amount));
    });

    on<RemoveFromCartEvent>((event, emit) async {
      await removeProductFromCart(event.productId);
      emit(CartIncrimentedState());
      emit(CartLoadingState());

      List<ProductModel> products = await fetchCartProducts();

      var amount = totalPrice(products);
      emit(CartFetchedState(productmodels: products, totalprice: amount));
    });
  }
}

Future<List<ProductModel>> fetchFavProducts() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(userId).get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      List<dynamic> cartProductIds =
          userSnapshot.get('favorites') as List<dynamic>;

      List<String> productIds = cartProductIds.cast<String>();

      // Step 2: Fetch the products using the product IDs from the cart
      List<ProductModel> cartProducts = await fetchProductsByIds(productIds);

      return cartProducts;
    } else {
      print('User document does not exist');
      return [];
    }
  } catch (e) {
    print('Error fetching cart products: $e');
    return [];
  }
}

Future<List<ProductModel>> fetchProductsByIds(List<String> productIds) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    List<Future<DocumentSnapshot>> futures = productIds.map((productId) {
      return firestore.collection('products').doc(productId).get();
    }).toList();

    List<DocumentSnapshot> snapshots = await Future.wait(futures);

    List<ProductModel> products = snapshots
        .where((doc) => doc.exists)
        .map((doc) => ProductModel.fromDocument(doc))
        .toList();

    return products;
  } catch (e) {
    print('Error fetching product details: $e');
    return [];
  }
}

Future<List<ProductModel>> fetchCartProductsByIds(
    List<String> productIds, List<int> count, List<String> sizes) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    List<Future<DocumentSnapshot>> futures = productIds.map((productId) {
      return firestore.collection('products').doc(productId).get();
    }).toList();

    List<DocumentSnapshot> snapshots = await Future.wait(futures);

    List<ProductModel> products = snapshots
        .where((doc) => doc.exists)
        .map((doc) => ProductModel.fromDocument(doc))
        .toList();
    for (int i = 0; i < productIds.length; i++) {
      products[i].count = count[i];
      products[i].selectedsize =
          sizes[i]; // Ensure count is associated with the right product
    }

    return products;
  } catch (e) {
    print('Error fetching product details: $e');
    return [];
  }
}

Future<List<ProductModel>> fetchCartProducts() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(userId).get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      Map<String, dynamic> cartzMap = userSnapshot.get('cart2');

      print(cartzMap);
      List<String> productIds = cartzMap.keys.cast<String>().toList();

      print(productIds);
      
      var count = [];
      var size = [];

      for (int i = 0; i < productIds.length; i++) {
        count.add(cartzMap.values.toList()[i][1]);
      }

      for (int i = 0; i < productIds.length; i++) {
        size.add(cartzMap.values.toList()[i][0]);
      }

      List<int> counts = count.cast<int>();
      print(counts);

      List<String> sizes = size.cast<String>();
      print(sizes);

      List<int> productcount = count.cast<int>();

      List<ProductModel> cartProducts =
          await fetchCartProductsByIds(productIds, productcount, sizes);

      return cartProducts;
    } else {
      print('User document does not exist');
      return [];
    }
  } catch (e) {
    print('Error fetching cart products: $e');
    return [];
  }
}

Future<void> incrementProductById(
    String productId, List<dynamic> updatedValues) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    print(updatedValues);
    // Reference to the user's document
    DocumentReference userDocRef = firestore.collection('users').doc(userId);

    // Update the specific product count in the 'cart2' map
    await userDocRef.update({'cart2.$productId': updatedValues});

    print('Product updated successfully!');
  } catch (e) {
    print('Error updating product: $e');
  }
}

Future<void> decrementProductById(
    String productId, Map<String, dynamic> updatedValues) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    // Reference to the user's document
    DocumentReference userDocRef = firestore.collection('users').doc(userId);

    // Update the specific product count in the 'cart2' map
    await userDocRef.update({'cart2.$productId': updatedValues[productId]});

    print('Product updated successfully!');
  } catch (e) {
    print('Error updating product: $e');
  }
}

int totalPrice(List<ProductModel> models) {
  int price = 0;
  for (int i = 0; i < models.length; i++) {
    price = price + (models[i].price * models[i].count!);
  }
  return price;
}

Future<void> removeProductFromCart(String productId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    // Reference to the user's document
    DocumentReference userDocRef = firestore.collection('users').doc(userId);

    // Remove the specific product from the 'cart2' map
    await userDocRef.update({
      'cart2.$productId':
          FieldValue.delete(), // Deletes the product from the cart
    });

    print('Product removed successfully!');
  } catch (e) {
    print('Error removing product: $e');
  }
}
