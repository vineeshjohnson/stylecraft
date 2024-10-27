import 'package:flutter/material.dart';

import '../../../../../../core/usecases/colors/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  final String backgroundImage;
  final String overlayImage;
  final String overlayText;

  const SplashScreenWidget({
    super.key,
    required this.backgroundImage,
    required this.overlayImage,
    required this.overlayText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 80.0,
          left: 20.0,
          right: 20.0,
          child: Text(
            overlayText,
            style: const TextStyle(
                decoration: TextDecoration.none,
                color: splashTextColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Matemasie'),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 180.0,
          left: 20.0,
          right: 20.0,
          child: Image.asset(
            overlayImage,
            width: 200.0,
            height: 200.0,
          ),
        ),
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(splashTextColor),
            strokeWidth: 4.0,
          ),
        ),
      ],
    );
  }
}
