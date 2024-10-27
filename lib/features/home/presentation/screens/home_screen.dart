import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:finalproject/features/home/presentation/screens/home_screen_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBlocBloc>(context);

    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is UnAuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              ElevatedButton(
                onPressed: () {
                  confirmDilogueBox(
                      context: context,
                      msg: 'Are you Sure Do you want to Logout',
                      click: () {
                        authbloc.add(LogOutEvent());
                        snackBar(context, 'Logged out Successfully');
                      });
                },
                child: const Text('Logout'),
              ),
            ],
            title: const Text('Home'),
          ),
          body: const HomePage(),
        );
      },
    );
  }
}
