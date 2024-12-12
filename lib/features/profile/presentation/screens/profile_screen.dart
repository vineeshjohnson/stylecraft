import 'dart:io';
import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/elevated_button.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/common_widgets/textform_field.dart';
import 'package:finalproject/features/products/presentation/widgets/appbar_widget.dart';
import 'package:finalproject/features/profile/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? imageurl;
  File? image;

  @override
  Widget build(BuildContext context) {
    bool isloading = false;

    return BlocProvider(
      create: (context) => UserprofileBloc()..add(ProfileFetchEvent()),
      child: BlocConsumer<UserprofileBloc, UserprofileState>(
        listener: (context, state) {
          if (state is UserProfileFetchedState) {
            nameController.text = state.uerdetails[0];
            emailController.text = state.uerdetails[1];
            mobileController.text = state.uerdetails[3];
            imageurl = state.uerdetails[2].isEmpty ? null : state.uerdetails[2];
          } else if (state is ImagePickedState) {
            image = state.image;
          } else if (state is LoadingStatw) {
            isloading = true;
          } else if (state is DataUpdatedState) {
            isloading = false;
            snackBar(context, 'Data Updated Successfully');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarWidget(
                title: 'User Profile',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      kheight50,
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<UserprofileBloc>()
                                .add(ImagePickingEvent());
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : (imageurl != null
                                        ? NetworkImage(imageurl!)
                                        : const AssetImage(
                                            'assets/images/nouser.jpeg'))
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      kheight40,
                      Textformfields(
                        controller: nameController,
                        icon: const Icon(Icons.person),
                        labeltext: 'Full Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      kheight40,
                      Textformfields(
                        readonly: true,
                        controller: emailController,
                        icon: const Icon(Icons.email),
                        labeltext: 'Email',
                      ),
                      kheight40,
                      Textformfields(
                        controller: mobileController,
                        icon: const Icon(Icons.phone),
                        labeltext: 'Mobile Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      kheight40,
                      CommonButton(
                        color: Colors.blueAccent,
                        formKey: _formKey,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (image != null) {
                              context.read<UserprofileBloc>().add(
                                  UpdateDataEvent(
                                      name: nameController.text,
                                      number: mobileController.text,
                                      image: image));
                            } else {
                              context
                                  .read<UserprofileBloc>()
                                  .add(UpdateDataEvent(
                                    name: nameController.text,
                                    number: mobileController.text,
                                  ));
                            }
                          }
                        },
                        buttonTxt: isloading ? 'Updating..' : 'Update',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
