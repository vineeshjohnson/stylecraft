part of 'userorders_bloc.dart';

sealed class UserordersEvent extends Equatable {
  const UserordersEvent();

  @override
  List<Object> get props => [];
}

class CompletedUserOrdersFetchingEvent extends UserordersEvent {}

class PendingUserOrdersFetchingEvent extends UserordersEvent {}

class CancelledUserOrdersFetchingEvent extends UserordersEvent {}

class OrderCancellationEvent extends UserordersEvent {
  final OrderModel model;
  final String reason;
  final String paymentmode;
  const OrderCancellationEvent(
      {required this.model, required this.reason, required this.paymentmode});
}

class OrderCancelReasonSelectioEvent extends UserordersEvent {
  final String reasonindex;
  const OrderCancelReasonSelectioEvent({required this.reasonindex});
}
