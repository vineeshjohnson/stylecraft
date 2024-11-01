import 'package:finalproject/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewWithDots extends StatelessWidget {
  PageViewWithDots({super.key, required this.state});
  final CategoryInitialFetchingState state;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: state.offers.length, // use offers length dynamically
            itemBuilder: (context, index) {
              return Image.network(
                state.offers[index],
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: state.offers.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.black,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
