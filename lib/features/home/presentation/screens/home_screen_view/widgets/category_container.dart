import 'package:finalproject/core/models/category_model.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/category_widget.dart';
import 'package:flutter/material.dart';

class CategoryShowingConatainer extends StatelessWidget {
  const CategoryShowingConatainer({
    super.key,
    required this.category,
  });

  final List<CategoryModel> category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 130,
      width: double.infinity,
      color: const Color.fromARGB(255, 223, 186, 93),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          var singlecategory = category[index];
          return CategoryIconWidget(
            imagepath: singlecategory.imagepath,
            categoryname: singlecategory.category,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }
}
