import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:flutter/material.dart';

class OptionTileWidget extends StatelessWidget {
  const OptionTileWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.function});
  final String text;
  final IconData icon;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 35, color: Colors.white),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, fontFamily: font4, color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.arrow_right, size: 35, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
