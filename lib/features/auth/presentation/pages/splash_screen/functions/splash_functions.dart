import 'package:flutter/material.dart';

import '../../onboarding_screen/onboarding_screen.dart';

class SplashFunctions {
  navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }
}
