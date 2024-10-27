import 'package:flutter/material.dart';

import '../../../../../core/usecases/common_widgets/scroll_dots.dart';
import '../../../../../core/usecases/strings/strings.dart';
import '../login_screen/login_screen.dart';
import 'widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              //onboarding screen widgets

              OnboardingScreen1(
                needButton: false,
                onNext: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                image: onboarding1,
                text: onboardingtext1,
                top: 60.0,
                left: 0.0,
                right: 250.0,
                textColor: Colors.black,
                onBack: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                buttonTextNext: 'Next',
                buttonTextBack: 'Back',
              ),
              OnboardingScreen1(
                onNext: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                image: onboarding2,
                text: onboardingtext2,
                top: 150.0,
                left: 15.0,
                right: 180.0,
                buttonTextNext: 'Next',
                buttonTextBack: 'Back',
                onBack: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                textColor: Colors.white,
              ),
              OnboardingScreen1(
                onNext: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                image: onboarding3,
                text: onboardingtext3,
                top: 210.0,
                left: 16.0,
                right: 180.0,
                onBack: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                buttonTextNext: 'Done',
                buttonTextBack: 'Back',
                textColor: Colors.white,
              ),
            ],
          ),

          //scroll dot view for scrolling effetx

          ScrollDot(currentPage: _currentPage),
        ],
      ),
    );
  }
}
