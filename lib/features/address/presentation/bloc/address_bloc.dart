import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) {});

    on<AddAddress>((event, emit) async {
      emit(AddressLoadingState());
      await addAddressForCurrentUser(event.address);

      emit(AddressAddedState());
    });

    on<AddressFetchingEvent>((event, emit) async {
      var v = await fetchCurrentUserAddresses();
      if (v.isEmpty) {
        emit(NoAddressState());
      } else {
        emit(AddressFetchedState(address: v));
      }
    });

    on<NavigateToAddAddress>((event, emit) async {
      emit(NavigateToAddAddressState());
    });

    on<EditAdressEvent>((event, emit) async {
      emit(AddressLoadingState());
      await replaceAddressAtIndex(
          index: event.index, newAddress: event.address);
      emit(AddressAddedState());
    });

    on<NavigateToEditAddress>((event, emit) async {
      emit(NavigateToEditAddressState(
          address: event.address, index: event.index));
    });

    on<DeleteAddressEvent>((event, emit) async {
      await deleteAddressAtIndex(index: event.index);
      emit(AddressDeletedState());
      var v = await fetchCurrentUserAddresses();
      if (v.isEmpty) {
        emit(NoAddressState());
      } else {
        emit(AddressFetchedState(address: v));
      }
    });
  }
}

Future<void> addAddressForCurrentUser(String newAddress) async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String uid = currentUser.uid;

      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);

      await userDoc.update({
        'address': FieldValue.arrayUnion([newAddress]),
      });

      print('Address added successfully!');
    } else {
      print('No user is currently signed in.');
    }
  } catch (e) {
    print('Failed to add address: $e');
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

Future<void> replaceAddressAtIndex({
  required int index,
  required String newAddress,
}) async {
  // Get the current user ID from FirebaseAuth
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Check if the user is signed in
  if (userId == null) {
    print("User is not signed in.");
    return;
  }

  // Reference to the user's document in Firestore
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  try {
    // Get the user's document
    DocumentSnapshot userDoc = await userRef.get();

    if (userDoc.exists) {
      // Fetch current address array from the document
      List<dynamic> addresses = userDoc.get('address');

      // Ensure the index is valid
      if (index >= 0 && index < addresses.length) {
        // Replace the address at the specified index
        addresses[index] = newAddress;

        // Update the address array in Firestore
        await userRef.update({
          'address': addresses,
        });
        print("Address updated successfully at index $index.");
      } else {
        print("Invalid index: $index. Address not updated.");
      }
    } else {
      print("User document does not exist.");
    }
  } catch (e) {
    print("Failed to update address: $e");
  }
}

Future<void> deleteAddressAtIndex({required int index}) async {
  // Get the current user ID from FirebaseAuth
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Check if the user is signed in
  if (userId == null) {
    print("User is not signed in.");
    return;
  }

  // Reference to the user's document in Firestore
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

  try {
    // Get the user's document
    DocumentSnapshot userDoc = await userRef.get();

    if (userDoc.exists) {
      // Fetch current address array from the document
      List<dynamic> addresses = userDoc.get('address');

      // Ensure the index is valid
      if (index >= 0 && index < addresses.length) {
        // Remove the address at the specified index
        addresses.removeAt(index);

        // Update the address array in Firestore
        await userRef.update({
          'address': addresses,
        });
        print("Address deleted successfully at index $index.");
      } else {
        print("Invalid index: $index. Address not deleted.");
      }
    } else {
      print("User document does not exist.");
    }
  } catch (e) {
    print("Failed to delete address: $e");
  }
}
