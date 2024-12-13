import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:finalproject/features/auth/presentation/pages/forgetpassword_screen/widgets/button.dart';
import 'package:finalproject/features/auth/presentation/pages/login_screen/methods/validation_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../otpverification_screen/otpverification_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final authBloc = BlocProvider.of<AuthBlocBloc>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is EmailVerifiedState) {
            navigateToOtpVerification(context, state.email);
          } else if (state is VerificationErrorState) {
            showSnackBar(context, state.msg[1]);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              buildBackgroundImage(screenHeight),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildForm(context, authBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackgroundImage(double screenHeight) {
    return Image.asset(
      forgetPasswordbackground,
      fit: BoxFit.fill,
      height: screenHeight,
    );
  }

  Widget buildForm(BuildContext context, AuthBlocBloc authBloc) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          kheight40,
          const Text(
            forgetpassword,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'NewAmsterdam',
            ),
            textAlign: TextAlign.center,
          ),
          kheight30,
          const Text(
            forgetpasssentence,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          buildEmailTextField(),
          kheight20,
          ForgetPasswordElevatedButton(
            formKey: formKey,
            authbloc: authBloc,
            emailController: emailController,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      validator: emailValidatorFunction,
    );
  }

  void navigateToOtpVerification(BuildContext context, String email) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(email: email),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    snackBar(context, message);
  }
}
