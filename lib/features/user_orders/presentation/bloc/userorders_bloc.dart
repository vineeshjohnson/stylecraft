import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'userorders_event.dart';
part 'userorders_state.dart';

class UserordersBloc extends Bloc<UserordersEvent, UserordersState> {
  UserordersBloc() : super(UserordersInitial()) {
    on<UserordersEvent>((event, emit) {});

    on<PendingUserOrdersFetchingEvent>((event, emit) async {
      emit(LoadingState());
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      var orders = await fetchUserOrders(userId!);
      var products = await fetchProductsInOrders(orders);
      print(orders);
      print('products');
      emit(PendingOrdersState(orders: orders, products: products));
    });
  }
}

Future<List<OrderModel>> fetchUserOrders(String uid) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('confirmed', isEqualTo: true)
        .get();
    print(querySnapshot.size);
    return querySnapshot.docs
        .map((doc) => OrderModel.fromFirestore(doc))
        .toList();
  } catch (e) {
    print("Error fetching orders: $e");
    return [];
  }
}

Future<List<ProductModel>> fetchProductsInOrders(
    List<OrderModel> orders) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<ProductModel> products = [];

    for (OrderModel order in orders) {
      final docSnapshot =
          await firestore.collection('products').doc(order.productid).get();

      if (docSnapshot.exists) {
        products.add(ProductModel.fromDocument(docSnapshot));
      }
    }
    return products;
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}
