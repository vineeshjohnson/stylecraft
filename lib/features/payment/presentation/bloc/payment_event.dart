part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentThroughWalletEvent extends PaymentEvent {}

class PaymentThroughCodEvent extends PaymentEvent {}

class PaymentThroughOnlineEvent extends PaymentEvent {
  final int amount;
  final int count;
  final String productid;
  final String size;
  final List<String> address;
  const PaymentThroughOnlineEvent(
      this.count, this.productid, this.size, this.address,
      {required this.amount});
}

class PaymentThroughOnlineForCartEvent extends PaymentEvent {
  final List<ProductModel> models;
  final List<int> counts;
  final List<String> sizes;
  final List<int> prices;
  final List<String> address;
  final int total;

  const PaymentThroughOnlineForCartEvent(
      {required this.models,
      required this.counts,
      required this.sizes,
      required this.prices,
      required this.address,
      required this.total});
}

class PaymentThroughWalletForCartEvent extends PaymentEvent {
  final List<ProductModel> models;
  final List<int> counts;
  final List<String> sizes;
  final List<int> prices;
  final List<String> address;
  final int total;

  const PaymentThroughWalletForCartEvent(
      {required this.models,
      required this.counts,
      required this.sizes,
      required this.prices,
      required this.address,
      required this.total});
}

class PaymentThroughCodForCartEvent extends PaymentEvent {
  final List<ProductModel> models;
  final List<int> counts;
  final List<String> sizes;
  final List<int> prices;
  final List<String> address;
  final int total;

  const PaymentThroughCodForCartEvent(
      {required this.models,
      required this.counts,
      required this.sizes,
      required this.prices,
      required this.address,
      required this.total});
}

class WalletPaymentProceedEvent extends PaymentEvent {
  final int count;
  final int price;
  final String productid;
  final String size;
  final List<String> address;

  const WalletPaymentProceedEvent(
      {required this.count,
      required this.price,
      required this.productid,
      required this.size,
      required this.address});
}

class CodPaymentProceedEvent extends PaymentEvent {
  final int count;
  final int price;
  final String productid;
  final String size;
  final List<String> address;

  const CodPaymentProceedEvent(
      {required this.count,
      required this.price,
      required this.productid,
      required this.size,
      required this.address});
}
