import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/ordermodel.dart';
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
    on<PaymentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<PaymentThroughWalletEvent>((event, emit) async {
      var v = await getUserWalletAmount();
      emit(WalletAmountFetchedState(walletamount: v!));
    });

    on<WalletPaymentProceedEvent>((event, emit) async {
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
          walletpayment: true,
          confirmed: true);
      var v = await getUserWalletAmount();
      int updatedamount = v! - event.price;
      updateWalletAmount(uid, updatedamount);
      bool success = await saveOrder(order);
      emit(WalletPurchasedState('49549449498', date, time, updatedamount,
          state: success));
    });

    on<CodPaymentProceedEvent>((event, emit) async {
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
          confirmed: true);

      bool success = await saveOrder(order);
      emit(WalletPurchasedState('49549449498', date, time, 5454454,
          state: success));
    });

    on<PaymentThroughOnlineEvent>((event, emit) async {
      emit(OnlinePaymentInitiatedState());

      String response = await paymentSheetInitilization(
          event.amount.round().toString(), "INR");

      if (response == 'Success') {
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
            confirmed: true);
        bool success = await saveOrder(order);
        emit(WalletPurchasedState('49549449498', date, time, 5454454,
            state: success));
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
      DateFormat('yyyy-MM-dd').format(now); // Format as '2024-11-06'
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

    print("response from API =" + responseFromStripeAPI.body);
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
