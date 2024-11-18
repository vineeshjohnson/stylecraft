import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:finalproject/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/common_widgets/textform_field.dart';
import '../../../../../core/usecases/strings/strings.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;

    final authbloc = BlocProvider.of<AuthBlocBloc>(context);
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is SignInErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            failDilogueBox(
                context: context, msg: state.msg, title: 'Registration failed');
          });
          print(state.msg);
        }
        if (state is AuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/bottomnav', (route) => false);
          });
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    signUpBackground,
                    fit: BoxFit.fill,
                    height: screenHeight,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 60.0),

                            const Text(
                              "Create Your Account",
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'NewAmsterdam',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40.0),

                            Textformfields(
                              controller: nameController,
                              labeltext: 'Name',
                              icon: const Icon(Icons.person),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),

                            Textformfields(
                              controller: emailController,
                              labeltext: 'Email',
                              icon: const Icon(Icons.email),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),

                            Textformfields(
                              controller: mobileController,
                              labeltext: 'Mobile Number',
                              icon: const Icon(Icons.phone),
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
                            const SizedBox(height: 20.0),

                            Textformfields(
                              controller: passwordController,
                              labeltext: 'Password',
                              icon: const Icon(Icons.lock),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),

                            Textformfields(
                              controller: confirmPasswordController,
                              labeltext: 'Confirm Password',
                              icon: const Icon(Icons.lock),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30.0),

                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  UserModel userModel = UserModel(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: mobileController.text,
                                      password: passwordController.text,
                                      uid: DateTime.now().toString(),
                                      address: []);

                                  authbloc
                                      .add(SignUpEvent(userModel: userModel));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                googleimage, // Path to your Google logo image
                                height: 30.0,
                                width: 30.0,
                              ),
                              label: const Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(color: Colors.black26),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),

                            // Already Have an Account? Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
