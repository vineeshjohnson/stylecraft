import 'package:finalproject/features/profile_screen/bloc/bloc/profile_bloc.dart';
import 'package:finalproject/features/profile_screen/presentation/pages/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../bloc/bloc/profile_event.dart';
import '../../bloc/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (context) =>
          ProfileBloc()..add(FetchUserProfileEvent(uid: currentUser!.uid)),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return Center(child: ProfileForm(userData: state.userData));
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileUpdated) {
              return ProfileForm(userData: state.userData);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
