import 'package:flutter/material.dart';

class ShippingWidget extends StatelessWidget {
  const ShippingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.local_shipping, color: Colors.blue),
        SizedBox(width: 8),
        Text(
          "Free Shipping",
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}
