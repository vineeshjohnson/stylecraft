part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class WalletAmountFetchedState extends PaymentState {
  final int walletamount;
  const WalletAmountFetchedState({required this.walletamount});
}

final class LoadingState extends PaymentState {}

final class WalletPurchasedState extends PaymentState {
  final bool state;
  final String orderId;
  final String orderDate;
  final String orderTime;
  final int walletAmount;
  const WalletPurchasedState(
      this.orderId, this.orderDate, this.orderTime, this.walletAmount,
      {required this.state});
}

final class OnlinePaymentInitiatedState extends PaymentState {}

final class OnlinePaymentCancelState extends PaymentState {}
