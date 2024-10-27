import 'package:finalproject/core/usecases/common_widgets/alert_dialogue.dart';
import 'package:finalproject/core/usecases/common_widgets/textform_field.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/profile_screen/bloc/bloc/profile_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/common_widgets/elevated_button.dart';
import '../../../bloc/bloc/profile_bloc.dart';

class ProfileForm extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfileForm({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userData['name'] ?? '';
    _phoneController.text = widget.userData['phone'] ?? '';
    _emailController.text = widget.userData['email'] ?? '';
    _imageUrl = widget.userData['imagepath'] ?? '';
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'imagepath': _imageUrl,
      };

      BlocProvider.of<ProfileBloc>(context).add(
        UpdateUserProfileEvent(
          uid: FirebaseAuth.instance.currentUser!.uid,
          updatedData: updatedData,
        ),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: 'Profile Updated',
            content: 'Your profile has been successfully updated.',
            buttonText: 'OK',
            buttonAction: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(onboarding1) as ImageProvider,
                ),
                const SizedBox(height: 16),
                Textformfields(
                  controller: _nameController,
                  icon: const Icon(Icons.person),
                  labeltext: 'Name',
                ),
                const SizedBox(height: 16),
                Textformfields(
                  controller: _phoneController,
                  icon: const Icon(Icons.phone),
                  labeltext: 'Phone',
                ),
                const SizedBox(height: 16),
                Textformfields(
                  controller: _emailController,
                  icon: const Icon(Icons.email),
                  labeltext: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CommonButton(
                  formKey: _formKey,
                  onTap: _updateProfile,
                  buttonTxt: 'Update',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
