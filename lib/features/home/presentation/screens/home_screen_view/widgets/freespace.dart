import 'package:flutter/material.dart';

class AddressShowingwidget extends StatelessWidget {
  const AddressShowingwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.blueGrey.shade100,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.location_on,
            size: 40,
          ),
          Text(
            'Deliver to Vineesh - Eranakulam 682304',
            style: TextStyle(fontFamily: 'AfacadFlux-SemiBold', fontSize: 17),
          ),
          Icon(Icons.keyboard_arrow_down_rounded)
        ],
      ),
    );
  }
}
