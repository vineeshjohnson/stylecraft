import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/address/presentation/screens/address.dart';
import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:finalproject/features/profile/presentation/screens/profile_screen.dart';
import 'package:finalproject/features/user_profile/widgets/box_widget.dart';
import 'package:finalproject/features/user_profile/widgets/option_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String user = 'User';
    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is AuthenticatedState) {
          user = state.user!.displayName!;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user,
                          style: const TextStyle(
                              color: Colors.white), // Text color to white
                        ),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.white), // Border color to white
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.currency_bitcoin,
                                  color: Colors.yellow),
                              Text(
                                '16',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    kheight30,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxWidget(icon: Icons.gif_box_outlined, text: 'Orders'),
                        BoxWidget(icon: Icons.shopping_bag, text: 'Wish List'),
                      ],
                    ),
                    kheight30,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxWidget(icon: Icons.gif_box_rounded, text: 'Cart'),
                        BoxWidget(icon: Icons.data_object, text: 'Products'),
                      ],
                    ),
                    kheight20,
                    Divider(
                      color: Colors.grey
                          .shade700, // Divider color to a lighter grey for contrast
                      thickness: 10,
                    ),
                    kheight30,
                    Text(
                      "Account Settings",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color to white
                        fontFamily: font5,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    kheight30,
                    OptionTileWidget(
                      icon: Icons.edit,
                      text: 'Edit Profile',
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserProfilePage()));
                      },
                    ),
                    kheight20,
                    OptionTileWidget(
                      icon: Icons.list_alt_rounded,
                      text: 'Saved Address',
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddressScreen()));
                      },
                    ),
                    kheight20,
                    OptionTileWidget(
                        function: () {},
                        icon: Icons.discount,
                        text: 'Offer Zone'),
                    kheight20,
                    Divider(
                      color: Colors.grey.shade700,
                      thickness: 10,
                    ),
                    kheight30,
                    Text(
                      "Feedback & Informations",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: font5,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    kheight30,
                    OptionTileWidget(
                        function: () {},
                        icon: Icons.note_alt_outlined,
                        text: 'Terms & Conditions'),
                    kheight30,
                    OptionTileWidget(
                        function: () {},
                        icon: Icons.question_mark_rounded,
                        text: 'Browse FAQs'),
                    kheight30,
                    Divider(
                      color: Colors.grey.shade700,
                      thickness: 10,
                    ),
                    kheight20,
                    ElevatedButton(
                      onPressed: () {
                        confirmDilogueBox(
                            context: context,
                            msg: 'Are you Sure Do you want to Logout',
                            click: () {
                              context.read<AuthBlocBloc>().add(LogOutEvent());
                              snackBar(context, 'Logged out Successfully');
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
