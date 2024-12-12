import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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

    on<CancelledUserOrdersFetchingEvent>((event, emit) async {
      emit(LoadingState());
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      var orders = await fetchCancelleddUserOrders(userId!);
      var products = await fetchProductsInOrders(orders);
      print(orders);
      print('products');
      emit(PendingOrdersState(orders: orders, products: products));
    });

    on<CompletedUserOrdersFetchingEvent>((event, emit) async {
      emit(LoadingState());
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      var orders = await fetchCompletedUserOrders(userId!);
      var products = await fetchProductsInOrders(orders);
      print(orders);
      print('products');
      emit(PendingOrdersState(orders: orders, products: products));
    });

    on<OrderCancellationEvent>((event, emit) async {
      emit(LoadingState());
      var cancelleddate = getTodayDateString();
      if (event.paymentmode == 'Wallet' ||
          event.paymentmode == 'Online Payment') {
        var v = await getUserWalletAmount();
        updateWalletAmount(event.model.uid, v! + event.model.price);
      }
      updateFieldByOrderId(event.model.orderid!, true, cancelleddate);
      updateCancelReason(event.model.orderid!, event.reason);
      emit(CancelledState(model: event.model));
    });

    on<OrderCancelReasonSelectioEvent>((event, emit) {
      emit(CancelReasonSelectedState(selectedreason: event.reasonindex));
      emit(ResetState());
    });
  }
}

Future<List<OrderModel>> fetchUserOrders(String uid) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('completed', isEqualTo: false)
        .where('cancelled', isEqualTo: false)
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

Future<List<OrderModel>> fetchCompletedUserOrders(String uid) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('completed', isEqualTo: true)
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

Future<List<OrderModel>> fetchCancelleddUserOrders(String uid) async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('cancelled', isEqualTo: true)
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

Future<void> updateFieldByOrderId(
    String orderId, dynamic newValue, String cancelleddate) async {
  try {
    // Query the 'orders' collection for a document with the specific 'orderid'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderid', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;

      await docRef
          .update({'cancelled': newValue, 'cancelleddate': cancelleddate});

      print(
          "fieldName updated successfully to $newValue for order ID: $orderId");
    } else {
      print("No document found with orderid: $orderId");
    }
  } catch (e) {
    print("Error updating fieldName for orderid $orderId: $e");
  }
}

Future<void> updateCancelReason(String orderId, String newValue) async {
  try {
    // Query the 'orders' collection for a document with the specific 'orderid'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderid', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;

      await docRef.update({'cancelreason': newValue});

      print(
          "fieldName updated successfully to $newValue for order ID: $orderId");
    } else {
      print("No document found with orderid: $orderId");
    }
  } catch (e) {
    print("Error updating fieldName for orderid $orderId: $e");
  }
}

Future<void> updateWalletAmount(String uid, int newAmount) async {
  try {
    // Reference to the user's document in Firestore
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);

    // Update the wallet amount
    await userDoc.update({'wallet': newAmount});

    print("Wallet amount updated successfully.");
  } catch (e) {
    print("Failed to update wallet amount: $e");
  }
}

Future<int?> getUserWalletAmount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is currently logged in.");
      return null;
    }
    String uid = user.uid;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return userDoc['wallet'] as int?;
    } else {
      print("User document does not exist.");
      return 0;
    }
  } catch (e) {
    print("Error fetching wallet amount: $e");
    return null;
  }
}

String getTodayDateString() {
  DateTime now = DateTime.now();
  String formattedDate =
      DateFormat('dd-MMMM-yyyy').format(now); // Format as '12-January-2024'
  return formattedDate;
}
