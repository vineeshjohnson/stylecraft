import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/ordermodel.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  Map<String, dynamic>? intentPaymentData;

  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {});

    on<PaymentThroughWalletEvent>((event, emit) async {
      var v = await getUserWalletAmount();
      emit(WalletAmountFetchedState(walletamount: v!));
    });

    on<WalletPaymentProceedEvent>((event, emit) async {
      emit(LoadingState());
      String orderId = FirebaseFirestore.instance.collection('orders').doc().id;

      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      String date = getTodayDateString();
      String time = getCurrentTimeString();
      OrderModel order = OrderModel(
          address: event.address,
          size: event.size,
          packed: false,
          uid: uid,
          productid: event.productid,
          date: date,
          time: time,
          price: event.price,
          count: event.count,
          walletpayment: true,
          confirmed: true,
          orderid: orderId,
          cancelled: false,
          cancelreason: '');
      var v = await getUserWalletAmount();
      int updatedamount = v! - event.price;
      updateWalletAmount(uid, updatedamount);
      bool success = await saveOrder(order);
      emit(WalletPurchasedState(orderId, date, time, updatedamount,
          state: success));
    });

    on<PaymentThroughWalletForCartEvent>((event, emit) async {
      emit(LoadingState());
      String orderId = FirebaseFirestore.instance.collection('orders').doc().id;

      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      String date = getTodayDateString();
      String time = getCurrentTimeString();
      List<OrderModel> allorders = [];
      for (int i = 0; i < event.models.length; i++) {
        OrderModel order = OrderModel(
            address: event.address,
            size: event.models[i].selectedsize!,
            packed: false,
            uid: uid,
            productid: event.models[i].productId!,
            date: date,
            time: time,
            price: event.prices[i],
            count: event.counts[i],
            onlinepayment: true,
            confirmed: true,
            orderid: orderId,
            cancelled: false,
            cancelreason: '');
        allorders.add(order);
      }
      bool? success;
      for (int i = 0; i < allorders.length; i++) {
        success = await saveOrder(allorders[i]);
      }
      var v = await getUserWalletAmount();
      int updatedamount = v! - event.total;
      updateWalletAmount(uid, updatedamount);
      emit(WalletPurchasedState(orderId, date, time, 5454454, state: success!));
      removeProductFromCart();
    });

    on<CodPaymentProceedEvent>((event, emit) async {
      String orderId = FirebaseFirestore.instance.collection('orders').doc().id;
      emit(LoadingState());
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      String date = getTodayDateString();
      String time = getCurrentTimeString();
      OrderModel order = OrderModel(
          address: event.address,
          size: event.size,
          packed: false,
          uid: uid,
          productid: event.productid,
          date: date,
          time: time,
          price: event.price,
          count: event.count,
          cashondelivery: true,
          confirmed: true,
          orderid: orderId,
          cancelled: false,
          cancelreason: '');

      bool success = await saveOrder(order);
      emit(WalletPurchasedState(orderId, date, time, 5454454, state: success));
    });

    on<PaymentThroughCodForCartEvent>((event, emit) async {
      String orderId = FirebaseFirestore.instance.collection('orders').doc().id;
      emit(LoadingState());
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;
      String date = getTodayDateString();
      String time = getCurrentTimeString();
      List<OrderModel> allorders = [];
      for (int i = 0; i < event.models.length; i++) {
        OrderModel order = OrderModel(
            address: event.address,
            size: event.models[i].selectedsize!,
            packed: false,
            uid: uid,
            productid: event.models[i].productId!,
            date: date,
            time: time,
            price: event.prices[i],
            count: event.counts[i],
            onlinepayment: true,
            confirmed: true,
            orderid: orderId,
            cancelled: false,
            cancelreason: '');
        allorders.add(order);
      }
      bool? success;
      for (int i = 0; i < allorders.length; i++) {
        success = await saveOrder(allorders[i]);
      }

      emit(WalletPurchasedState(orderId, date, time, 5454454, state: success!));
      removeProductFromCart();
    });

    on<PaymentThroughOnlineEvent>((event, emit) async {
      emit(OnlinePaymentInitiatedState());

      String response = await paymentSheetInitilization(
          event.amount.round().toString(), "INR");

      if (response == 'Success') {
        String orderId =
            FirebaseFirestore.instance.collection('orders').doc().id;

        User? user = FirebaseAuth.instance.currentUser;
        String uid = user!.uid;
        String date = getTodayDateString();
        String time = getCurrentTimeString();
        OrderModel order = OrderModel(
            address: event.address,
            size: event.size,
            packed: false,
            uid: uid,
            productid: event.productid,
            date: date,
            time: time,
            price: event.amount,
            count: event.count,
            onlinepayment: true,
            confirmed: true,
            orderid: orderId,
            cancelled: false,
            cancelreason: '');
        bool success = await saveOrder(order);
        
        
        emit(
            WalletPurchasedState(orderId, date, time, 5454454, state: success));
      } else if (response == 'Canceled') {
        emit(OnlinePaymentCancelState());
      }
      print(response);
    });

    on<PaymentThroughOnlineForCartEvent>((event, emit) async {
      emit(OnlinePaymentInitiatedState());

      String response = await paymentSheetInitilization(
          event.total.round().toString(), "INR");

      if (response == 'Success') {
        String orderId =
            FirebaseFirestore.instance.collection('orders').doc().id;

        User? user = FirebaseAuth.instance.currentUser;
        String uid = user!.uid;
        String date = getTodayDateString();
        String time = getCurrentTimeString();
        List<OrderModel> allorders = [];
        for (int i = 0; i < event.models.length; i++) {
          OrderModel order = OrderModel(
              address: event.address,
              size: event.models[i].selectedsize!,
              packed: false,
              uid: uid,
              productid: event.models[i].productId!,
              date: date,
              time: time,
              price: event.prices[i],
              count: event.counts[i],
              onlinepayment: true,
              confirmed: true,
              orderid: orderId,
              cancelled: false,
              cancelreason: '');
          allorders.add(order);
        }
        bool? success;
        for (int i = 0; i < allorders.length; i++) {
          success = await saveOrder(allorders[i]);
        }
        emit(WalletPurchasedState(orderId, date, time, 5454454,
            state: success!));
        removeProductFromCart();
      } else if (response == 'Canceled') {
        emit(OnlinePaymentCancelState());
      }
      print(response);
    });
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

Future<bool> saveOrder(OrderModel order) async {
  try {
    Map<String, dynamic> orderData = {
      'address': order.address,
      'uid': order.uid,
      'productid': order.productid,
      'date': order.date,
      'time': order.time,
      'price': order.price,
      'count': order.count,
      'size': order.size,
      'cashondelivery': order.cashondelivery ?? false,
      'walletpayment': order.walletpayment ?? false,
      'onlinepayment': order.onlinepayment ?? false,
      'confirmed': order.confirmed ?? false,
      'packed': order.packed,
      'shipped': order.shipped ?? false,
      'outofdelivery': order.outofdelivery ?? false,
      'completed': order.completed ?? false,
      'orderid': order.orderid,
      'cancelled': order.cancelled,
      'cancelreason': order.cancelreason,
      'packeddate': '',
      'shippeddate': '',
      'outfordeliverydate': '',
      'completeddate': '',
      'estimatedeliverydate': '',
      'cancelleddate': ''
    };

    await FirebaseFirestore.instance.collection('orders').add(orderData);

    return true;
  } catch (e) {
    print("Error saving order: $e");
    return false;
  }
}

String getTodayDateString() {
  DateTime now = DateTime.now();
  String formattedDate =
      DateFormat('dd-MMMM-yyyy').format(now); // Format as '12-January-2024'
  return formattedDate;
}

String getCurrentTimeString() {
  DateTime now = DateTime.now();
  String formattedTime =
      DateFormat('hh:mm a').format(now); // Example: '01:12 PM'
  return formattedTime;
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

Future<String> showPaymentSheet(intentPaymentData) async {
  try {
    // Present the payment sheet
    await Stripe.instance.presentPaymentSheet();

    // If no exception occurs, the payment is successful
    intentPaymentData = null;

    return 'Success';
    // Clear the intentPaymentData after successful payment
  } on StripeException catch (error) {
    // Handle Stripe-specific exceptions
    if (kDebugMode) {
      print("StripeException: $error");
    }
    return 'Canceled';
  } catch (err) {
    // Handle general exceptions
    if (kDebugMode) {
      print("Error: $err");
    }
    return 'Failed';
  }
}

makeIntentForPayment(amountToBeCharge, currency) async {
  try {
    Map<String, dynamic>? paymentInfo = {
      "amount": (int.parse(amountToBeCharge) * 100).toString(),
      "currency": currency,
      "payment_method_types[]": "card"
    };

    var responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $secretkey",
          "Content-Type": "application/X-www-form-urlencoded"
        });

    print("response from API =${responseFromStripeAPI.body}");
    return jsonDecode(responseFromStripeAPI.body);
  } catch (errrorMsg) {
    if (kDebugMode) {
      print(errrorMsg);
    } else {
      print(errrorMsg.toString());
    }
  }
}

Future<String> paymentSheetInitilization(amountToBeCharge, currency) async {
  try {
    Map<String, dynamic>? intentPaymentData =
        await makeIntentForPayment(amountToBeCharge, currency);

    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                allowsDelayedPaymentMethods: true,
                paymentIntentClientSecret: intentPaymentData!["client_secret"],
                style: ThemeMode.dark,
                merchantDisplayName: "Style Craft"))
        .then((val) {
      print(val);
      print('fvgwduygfuydfgu8ygsdfygsdyuf');
    });

    String response = await showPaymentSheet(intentPaymentData);
    return response;
  } catch (errrorMsg, s) {
    if (kDebugMode) {
      print(s);
    } else {
      print(errrorMsg.toString());
    }

    return 'Failed';
  }
}

Future<void> removeProductFromCart() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String userId = auth.currentUser!.uid;

  try {
    // Reference to the user's document
    DocumentReference userDocRef = firestore.collection('users').doc(userId);

    // Remove the specific product from the 'cart2' map
    await userDocRef.update({
      'cart2': {}, // Deletes the product from the cart
    });

    print('Product removed successfully!');
  } catch (e) {
    print('Error removing product: $e');
  }
}
