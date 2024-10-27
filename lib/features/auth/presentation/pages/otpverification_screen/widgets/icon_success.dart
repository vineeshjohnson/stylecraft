import 'package:flutter/material.dart';

class IconSuccessWidget extends StatelessWidget {
  const IconSuccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle,
      size: 100.0,
      color: Colors.greenAccent.shade400,
    );
  }
}
