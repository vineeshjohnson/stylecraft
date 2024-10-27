import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/home/presentation/bloc/home_bloc.dart';
import 'package:finalproject/features/home/presentation/functions.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/brand_banner_widget.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/freespace.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/page_view_offer_widget.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/widgets/under_widget_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              appBar: appBarFunction(state),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const AddressShowingwidget(),
                    categoryShowing(state),
                    kheight10,
                    const PageViewWithDots(),
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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
