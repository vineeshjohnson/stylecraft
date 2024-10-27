import 'package:flutter/material.dart';

import '../../../../../../core/usecases/strings/strings.dart';

class EmailVerifiedTitleWidget extends StatelessWidget {
  const EmailVerifiedTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      emailverifiedtext,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'NewAmsterdam',
      ),
      textAlign: TextAlign.center,
    );
  }
}
