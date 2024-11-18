part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderDetailsTriggeredState extends OrderState {
  final int price;
  final int discountamount;
  final int totalamount;
  final int count;

  const OrderDetailsTriggeredState(
      {required this.price,
      required this.discountamount,
      required this.totalamount,
      required this.count});
}

class SetState extends OrderState {}

class AddressFetchedState extends OrderState {
  final List<String> address;
  const AddressFetchedState({required this.address});
}

class NavigatedToAddAddressState extends OrderState {}

class AddressChangedState extends OrderState {
  final int selectedindex;
  const AddressChangedState({required this.selectedindex});
}
