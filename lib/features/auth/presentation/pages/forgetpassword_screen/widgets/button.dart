import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';

class ForgetPasswordElevatedButton extends StatelessWidget {
  const ForgetPasswordElevatedButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.authbloc,
    required this.emailController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final AuthBlocBloc authbloc;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Trigger password reset event only if validation passes
          authbloc.add(ForgetPasswordEvent(email: emailController.text));
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
        'Send Reset Link',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
