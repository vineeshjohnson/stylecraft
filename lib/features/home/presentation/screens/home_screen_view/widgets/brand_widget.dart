import 'package:finalproject/features/products/presentation/product_screen/product_screen.dart';
import 'package:flutter/material.dart';

class BrandWidgetHome extends StatelessWidget {
  const BrandWidgetHome(
      {super.key, required this.brandname, required this.imagepath});
  final String brandname;
  final String imagepath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductView(
                  brand: brandname,
                )));
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.fill),
        ),
        height: 190,
        width: 130,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(imagepath)),
                ),
                height: 120,
                width: 100,
              ),
            ),
            Positioned(
              bottom: 6,
              child: Text(
                brandname,
                style: const TextStyle(
                    fontFamily: 'NewAmsterdam',
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
