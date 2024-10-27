import 'package:finalproject/features/products/presentation/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget(
      {super.key, required this.imagepath, required this.categoryname});
  final String imagepath;
  final String categoryname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductView(
                  category: categoryname,
                )));
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              imagepath,
              fit: BoxFit.fill,
              width: 70, // Width and height to match the CircleAvatar radius
              height: 70,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                // Shimmer effect during image load
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 70,
                  height: 70,
                  child: Icon(Icons.image_not_supported,
                      size: 70, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: 7), // Add space between the image and text
          Text(categoryname),
        ],
      ),
    );
  }
}
