part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressAddedState extends AddressState {}

final class AddressFetchedState extends AddressState {
  final List<String> address;

  const AddressFetchedState({required this.address});
}

final class AddressLoadingState extends AddressState {}

final class NavigateToAddAddressState extends AddressState {}

final class NavigateToEditAddressState extends AddressState {
  final List<String> address;
  final int index;
  const NavigateToEditAddressState(
      {required this.address, required this.index});
}

final class NoAddressState extends AddressState {}

final class AddressDeletedState extends AddressState {}
