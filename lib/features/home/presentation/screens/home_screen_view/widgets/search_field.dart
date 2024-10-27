import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchcontroller});
  final TextEditingController searchcontroller;
  @override
  Widget build(BuildContext context) {
    return SearchBarAnimation(
      searchBoxWidth: 280,
      isOriginalAnimation: false,
      buttonBorderColour: Colors.black45,
      onFieldSubmitted: (String value) {
        debugPrint('onFieldSubmitted value $value');
      },
      textEditingController: searchcontroller,
      trailingWidget: const Icon(Icons.clear),
      secondaryButtonWidget: const Icon(Icons.search),
      buttonWidget: const Icon(Icons.search),
    );
  }
}
