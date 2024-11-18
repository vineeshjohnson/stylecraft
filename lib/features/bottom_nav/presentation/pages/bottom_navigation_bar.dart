import 'package:finalproject/features/bottom_nav/presentation/bloc/bottomnavcontrole_bloc.dart';
import 'package:finalproject/features/bottom_nav/presentation/widgets/bottom_navbar_widget.dart';
import 'package:finalproject/features/cart/presentation/widgets/tabbar.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/home_view.dart';
import 'package:finalproject/features/user_orders/presentation/screens/orders_tabbar.dart';
import 'package:finalproject/trial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBars extends StatelessWidget {
  const BottomNavigationBars({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? widget;

    return BlocProvider(
      create: (context) => BottomnavcontroleBloc(),
      child: BlocBuilder<BottomnavcontroleBloc, BottomnavcontroleState>(
        builder: (context, state) {
          if (state is BottomnavcontroleInitial) {
            widget = const HomePage();
          } else if (state is BottomnavcontroleHomeState) {
            widget = const HomePage();
          } else if (state is BottomnavcontroleShopState) {
            widget = const FavoritesAndCartPage();
          } else if (state is BottomnavcontroleCartState) {
            widget = const UserOrdersPage();
          } else if (state is BottomnavcontroleProfileState) {
            widget = const BrandProductsScreen();
          }
          return Scaffold(
            body: widget,
            bottomNavigationBar: BottomNavbarWidget(key: key),
          );
        },
      ),
    );
  }
}
