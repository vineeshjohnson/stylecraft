import 'package:flutter/material.dart';

class ScrollDot extends StatelessWidget {
  const ScrollDot({
    super.key,
    required int currentPage,
  }) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(3, (int index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 10.0,
            width: (index == _currentPage) ? 20.0 : 10.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: (index == _currentPage) ? Colors.white : Colors.black,
            ),
          );
        }),
      ),
    );
  }
}
