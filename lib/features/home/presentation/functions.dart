import 'package:finalproject/core/models/category_model.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/home/presentation/bloc/home_bloc.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/brand_widget.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/category_container.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/under_money_widget.dart';
import 'package:flutter/material.dart';

Padding underMoney() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UnderMoneyWidget(price: '399'),
        UnderMoneyWidget(price: '699'),
        UnderMoneyWidget(price: '999'),
      ],
    ),
  );
}

SizedBox brandShowing(CategoryInitialFetchingState state, List<String> values) {
  return SizedBox(
    height: 190,
    width: double.infinity,
    child: ListView.separated(
      itemBuilder: (BuildContext context, int index) => BrandWidgetHome(
        brandname: state.brands[index],
        imagepath: values[index],
      ),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 10,
      ),
      itemCount: state.brands.length,
      scrollDirection: Axis.horizontal,
    ),
  );
}

FutureBuilder<List<CategoryModel>> categoryShowing(
    CategoryInitialFetchingState state) {
  return FutureBuilder<List<CategoryModel>>(
      future: state.categorymodel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CategoryShowingConatainer(
            category: snapshot.requireData,
          );
        }
      });
}

PreferredSize appBarFunction(CategoryInitialFetchingState state) {
  return PreferredSize(
    preferredSize: const Size(5, 70),
    child: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 110,
              width: 110,
            ),
            Text(
              'STYLE CRAFT',
              style: TextStyle(fontFamily: font5, fontSize: 20),
            ),
          ],
        ),
        shadowColor: Colors.black,
        scrolledUnderElevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: state.image.isEmpty
                      ? const AssetImage('assets/images/nouser.jpeg')
                      : NetworkImage(state.image),
                ),
                Text(
                  state.username,
                  style: TextStyle(fontFamily: font4),
                )
              ],
            ),
          ),
        ]),
  );
}
