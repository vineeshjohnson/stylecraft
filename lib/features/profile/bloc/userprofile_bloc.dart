import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserprofileBloc extends Bloc<UserprofileEvent, UserprofileState> {
  UserprofileBloc() : super(UserprofileInitial()) {
    on<UserprofileEvent>((event, emit) {});

    on<ProfileFetchEvent>((event, emit) async {
      var address = await fetchCurrentUserDetails();
      emit(UserProfileFetchedState(uerdetails: address));
    });

    on<ImagePickingEvent>((event, emit) async {
      var v = await imagepick();

      if (v != null) {
        emit(ImagePickedState(image: v));
      }
    });

    on<UpdateDataEvent>((event, emit) async {
      emit(LoadingStatw());

      String? imageurl;
      if (event.image != null) {
        imageurl = await uploadProfileImage(event.image!);
      }
      await updateUserProfile(
          name: event.name, phone: event.number, imagepath: imageurl);
      var address = await fetchCurrentUserDetails();

      emit(UserProfileFetchedState(uerdetails: address));
      emit(DataUpdatedState());
    });
  }
}

Future<List<String>> fetchCurrentUserDetails() async {
  // Get the current user ID from FirebaseAuth
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Check if the user is signed in
  if (userId == null) {
    print("User is not signed in.");
    return [];
  }

  try {
    // Reference to the user's document in Firestore
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Check if the document exists and contains the required data
    if (userDoc.exists) {
      // Extract the necessary fields: name, email, imagepath, and phone
      final userData = userDoc.data();
      String name = userData?['name'] ?? 'No name';
      String email = userData?['email'] ?? 'No email';
      String imagePath = userData?['imagepath'] ?? '';
      String phone = userData?['phone'] ?? 'No phone number';

      // Return the user details as a list of strings
      return [name, email, imagePath, phone];
    } else {
      print("User document does not exist.");
      return [];
    }
  } catch (e) {
    print("Failed to fetch user details: $e");
    return [];
  }
}

Future<File?> imagepick() async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

Future<String> uploadProfileImage(File imageFile) async {
  try {
    String filePath =
        'user_images/${DateTime.now().millisecondsSinceEpoch}.png';

    final uploadTask =
        await FirebaseStorage.instance.ref(filePath).putFile(imageFile);

    // Get the download URL for the uploaded image
    String downloadUrl = await uploadTask.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    print("Failed to upload image and update banners array: $e");
    return '';
  }
}

Future<void> updateUserProfile({
  String? name,
  String? imagepath,
  String? phone,
}) async {
  try {
    // Get the current user's UID
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is currently signed in.");
      return;
    }

    String uid = currentUser.uid;

    // Reference to the user's document in Firestore
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);

    // Data to update
    Map<String, dynamic> updatedData = {};

    if (name != null) updatedData['name'] = name;
    if (imagepath != null) updatedData['imagepath'] = imagepath;
    if (phone != null) updatedData['phone'] = phone;

    // Update Firestore document
    await userDoc.update(updatedData);
    print("User profile updated successfully.");
  } catch (e) {
    print("Error updating user profile: $e");
  }
}
