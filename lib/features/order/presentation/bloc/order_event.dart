part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class TriggerOrderSummaryEvent extends OrderEvent {
  final ProductModel model;
  final int productcount;
  const TriggerOrderSummaryEvent(
      {required this.model, required this.productcount});
}

class ProductCountChangeEvent extends OrderEvent {
  final int counts;
  const ProductCountChangeEvent({required this.counts});
}

class AddressaFetchingEvent extends OrderEvent {}

class NavigateToAddAddressEvent extends OrderEvent {}

class AddressChangedEvent extends OrderEvent {
  final int selectedaddress;
  const AddressChangedEvent({required this.selectedaddress});
}