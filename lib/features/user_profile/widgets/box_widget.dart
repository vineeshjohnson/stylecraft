import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.icon, required this.text,required this.function});
  final String text;
  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white), // Border color to white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, color: Colors.white), // Icon color to white
            Text(text,
                style:
                    const TextStyle(color: Colors.white)), // Text color to white
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
