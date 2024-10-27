import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewWithDots extends StatefulWidget {
  const PageViewWithDots({super.key});

  @override
  _PageViewWithDotsState createState() => _PageViewWithDotsState();
}

class _PageViewWithDotsState extends State<PageViewWithDots> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {});
            },
            children: List.generate(5, (index) {
              return Container(
                child: Image.asset(
                  offers[index],
                  fit: BoxFit.fill,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: 5,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
