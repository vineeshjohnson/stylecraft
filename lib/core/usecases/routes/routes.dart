import 'package:finalproject/features/auth/presentation/pages/forgetpassword_screen/forgetpassword_screen.dart';
import 'package:finalproject/features/auth/presentation/pages/login_screen/login_screen.dart';
import 'package:finalproject/features/auth/presentation/pages/onboarding_screen/onboarding_screen.dart';
import 'package:finalproject/features/auth/presentation/pages/registration_screen/registration_screen.dart';
import 'package:finalproject/features/auth/presentation/pages/splash_screen/splash_screen.dart';
import 'package:finalproject/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../features/home/presentation/screens/home_screen.dart';

class Routes {
  Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/login': (context) => LoginScreen(),
    '/registration': (context) => RegistrationScreen(),
    '/forgetpassword': (context) => ForgetPasswordScreen(),
    '/home': (context) => const HomeScreen(),
    '/bottomnav': (context) => const BottomNavigationBars()
  };
}
