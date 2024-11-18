part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddAddress extends AddressEvent {
  final String address;
  const AddAddress({required this.address});
}

class AddressFetchingEvent extends AddressEvent {}

class NavigateToAddAddress extends AddressEvent {}

class NavigateToEditAddress extends AddressEvent {
  final int index;
  final List<String> address;
  const NavigateToEditAddress({required this.address, required this.index});
}

class EditAdressEvent extends AddressEvent {
  final int index;
  final String address;
  const EditAdressEvent({required this.address, required this.index});
}

class DeleteAddressEvent extends AddressEvent {
  final int index;
  const DeleteAddressEvent({required this.index});
}
