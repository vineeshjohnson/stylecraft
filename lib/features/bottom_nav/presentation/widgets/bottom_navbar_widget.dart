import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finalproject/features/bottom_nav/presentation/bloc/bottomnavcontrole_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarWidget extends StatelessWidget {
  BottomNavbarWidget({
    super.key,
  });

  final List<Widget> _list = [
    const Icon(Icons.home),
    const Icon(Icons.card_travel),
    const Icon(Icons.shopify_rounded),
    const Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavcontroleBloc, BottomnavcontroleState>(
      builder: (context, state) {
        if (state is BottomnavcontroleInitial) {
        } else if (state is BottomnavcontroleHomeState) {
        } else if (state is BottomnavcontroleShopState) {
        } else if (state is BottomnavcontroleCartState) {
        } else if (state is BottomnavcontroleProfileState) {}
        return CurvedNavigationBar(
          backgroundColor: Colors.black,
          animationCurve: Curves.easeInOutCubicEmphasized,
          items: _list,
          index: 0,
          onTap: (index) {
            final bloc = BlocProvider.of<BottomnavcontroleBloc>(context);
            if (index == 0) {
              bloc.add(HomeEvent());
            } else if (index == 1) {
              bloc.add(ShopEvent());
            } else if (index == 2) {
              bloc.add(CartEvent());
            } else if (index == 3) {
              bloc.add(ProfileEvent());
            }
          },
        );
      },
    );
  }
}
