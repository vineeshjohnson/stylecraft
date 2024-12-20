import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<TriggerOrderSummaryEvent>((event, emit) {
      print('object');
      emit(OrderDetailsTriggeredState(
          price: (event.model.price * event.productcount),
          discountamount: event.productcount *
              ((event.model.price * event.model.discountpercent!) ~/ 100),
          totalamount: event.model.price * event.productcount + 40,
          count: event.productcount));
      emit(SetState());
    });

    on<AddressaFetchingEvent>((event, emit) async {
      var v = await fetchCurrentUserAddresses();
      emit(AddressFetchedState(address: v));
    });

    on<NavigateToAddAddressEvent>((event, emit) async {
      emit(NavigatedToAddAddressState());
    });

    on<AddressChangedEvent>((event, emit) async {
      emit(AddressChangedState(selectedindex: event.selectedaddress));
      emit(SetState());
    });

    on<CartCheckoutProductIncrimentEvent>((event, emit) async {
      List<int> newcount = event.counts;
      newcount[event.index] = newcount[event.index] + 1;
      emit(CartCheckoutTriggeredState(
        newcounts: newcount,
      ));
      emit(SetState());
    });

    on<CartCheckoutProductDecrimentEvent>((event, emit) async {
      List<int> newcount = event.counts;
      newcount[event.index] = newcount[event.index] - 1;
      emit(CartCheckoutTriggeredState(
        newcounts: newcount,
      ));
      emit(SetState());
    });
  }
}

Future<List<String>> fetchCurrentUserAddresses() async {
  try {
    // Get the currently signed-in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is signed in.");
      return [];
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists && userDoc.data()!.containsKey('address')) {
      List<String> addresses = List<String>.from(userDoc['address']);
      return addresses;
    } else {
      print("No addresses found for this user.");
      return [];
    }
  } catch (e) {
    print("Error fetching addresses: $e");
    return [];
  }
}
