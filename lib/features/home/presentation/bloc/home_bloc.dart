import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject/core/models/category_model.dart';
import 'package:finalproject/core/models/product_model.dart';
import 'package:finalproject/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<CategoryInitialFetchEvent>((event, emit) async {
      String username = await userName();
      String image = await images();
      List<String> brands = await getAllBrandNames();
      List<String> offers = await _fetchBannerUrls();
      List<String> address = await fetchCurrentUserAddresses();
      emit(CategoryInitialFetchingState(
          categorymodel: fetchCategories(),
          username: username,
          image: image,
          brands: brands,
          offers: offers,
          address: address));
    });
  }
}

Future<List<CategoryModel>> fetchCategories() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore.collection('category').get();
  return snapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
}

Future<String> userName() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;

  QuerySnapshot snapshot = await firestore
      .collection('users')
      .where('uid', isEqualTo: user!.uid)
      .get();

  UserModel userModel =
      snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).first;
  return userModel.name!;
}

Future<String> images() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;

  QuerySnapshot snapshot = await firestore
      .collection('users')
      .where('uid', isEqualTo: user!.uid)
      .get();

  UserModel userModel =
      snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).first;
  if (userModel.imagepath == null) {
    return '';
  } else {
    return userModel.imagepath!;
  }
}

Future<List<String>> getAllBrandNames() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore.collection('products').get();

  List<String> brandNames = snapshot.docs.map((doc) {
    return doc['brand'] as String;
  }).toList();

  return brandNames.toSet().toList();
}

Future<List<String>> _fetchBannerUrls() async {
  DocumentReference offerBannerRef =
      FirebaseFirestore.instance.collection('offerbanner').doc('banners');
  DocumentSnapshot snapshot = await offerBannerRef.get();

  List<dynamic> banners = snapshot.exists ? (snapshot['banner'] ?? []) : [];
  return List<String>.from(banners);
}

Future<List<String>> fetchCurrentUserAddresses() async {
  try {
    // Get the currently signed-in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is signed in.");
      return [];
    }

    // Fetch the user's document from the 'users' collection using their UID
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    // Check if the document exists and contains the address field
    if (userDoc.exists && userDoc.data()!.containsKey('address')) {
      List<String> addresses = List<String>.from(userDoc['address']);
      return addresses;
    } else {
      print("No addresses found for this user.");
      return [];
    }
  } catch (e) {
    print("Error fetching addresses: $e");
    return []; // Return an empty list in case of an error
  }
}
