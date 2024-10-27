import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:flutter/material.dart';

class UnderWidgetBanner extends StatelessWidget {
  const UnderWidgetBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color.fromARGB(255, 205, 216, 222),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Findout Products\nUnder Your Budget',
              style: TextStyle(fontFamily: font5, fontSize: 20),
            ),
            Image.asset(
              'assets/images/money.png',
              height: 80,
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}
