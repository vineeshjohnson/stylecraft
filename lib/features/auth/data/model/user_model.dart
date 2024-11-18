import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  String? imagepath;
  List<String>? address;

  UserModel(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.uid,
      this.imagepath,
      this.address});

  // Factory method to create a UserModel from Firestore DocumentSnapshot
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      name: data['name'], // Corrected to map 'name' field
      email: data['email'], // Map the correct 'email' field
      // Usually, the document ID is the user's UID
      imagepath: data['imagepath'], // Add image path if stored
    );
  }

  // Optionally, you can add a method to convert a UserModel to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'imagepath': imagepath,
    };
  }
}
