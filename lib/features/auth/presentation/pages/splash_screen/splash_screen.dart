import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/strings/strings.dart';
import 'widgets/splash_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    //using the bloclistner checking the state

    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/bottomnav', (route) => false);
        } else if (state is UnAuthenticatedState) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      },

      //splash screen widget

      child: const SplashScreenWidget(
          backgroundImage: splashback,
          overlayImage: splash,
          overlayText: splashText),
    );
  }
}
