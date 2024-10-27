import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack; // Callback for the back button
  final String image;
  final String text;
  final double top;
  final double left;
  final double right;
  final String buttonTextNext;
  final String buttonTextBack;
  final Color textColor;
  final bool? needButton;

  const OnboardingScreen1(
      {super.key,
      required this.onNext,
      required this.onBack,
      required this.image,
      required this.text,
      required this.top,
      required this.left,
      required this.right,
      required this.buttonTextNext,
      required this.buttonTextBack,
      required this.textColor,
      this.needButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: top,
            left: left,
            right: right,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'NewAmsterdam',
                color: textColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (needButton == false)
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                if (needButton == null || needButton == true)
                  ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      buttonTextBack,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    buttonTextNext,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
