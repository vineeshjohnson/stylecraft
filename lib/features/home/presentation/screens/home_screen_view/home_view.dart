import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/home/presentation/bloc/home_bloc.dart';
import 'package:finalproject/features/home/presentation/functions.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/brand_banner_widget.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/address_showing.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/page_view_offer_widget.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/under_widget_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> values = brandlist.values.toList();

    return BlocProvider(
      create: (context) => HomeBloc()..add(CategoryInitialFetchEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryInitialFetchingState) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: appBarFunction(state),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    AddressShowingwidget(
                      state: CategoryInitialFetchingState(
                          categorymodel: state.categorymodel,
                          username: state.username,
                          image: state.image,
                          brands: state.brands,
                          offers: state.offers,
                          address: state.address),
                    ),
                    categoryShowing(state),
                    kheight10,
                    PageViewWithDots(
                      state: CategoryInitialFetchingState(
                          categorymodel: state.categorymodel,
                          username: state.username,
                          image: state.image,
                          brands: state.brands,
                          offers: state.offers,
                          address: state.address),
                    ),
                    kheight20,
                    const BrandBanner(),
                    kheight20,
                    brandShowing(state, values),
                    kheight10,
                    const UnderWidgetBanner(),
                    underMoney()
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Lottie.asset("assets/images/loading.json",
                    width: double.infinity, height: 300),
              ),
            );
          }
        },
      ),
    );
  }
}
