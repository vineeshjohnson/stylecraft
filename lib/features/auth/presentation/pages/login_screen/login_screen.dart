import 'package:finalproject/core/usecases/common_widgets/confirm_dialogues.dart';
import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/common_widgets/textform_field.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:finalproject/features/auth/presentation/pages/login_screen/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/common_widgets/google_elevatedbutton.dart';
import '../registration_screen/registration_screen.dart';
import 'methods/validation_methods.dart';
import 'widgets/donthaveaccount_widget.dart';
import 'widgets/forgetpassword_widget.dart';
import 'widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;

    final authbloc = BlocProvider.of<AuthBlocBloc>(context);

    return BlocListener<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/bottomnav', (route) => false);

            successDilogueBox(context: context, msg: successLogin);
          }

          if (state is AuthenticatonErrorState) {
            failDilogueBox(
                context: context, msg: state.msg[1], title: state.msg[0]);
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    loginBackground,
                    fit: BoxFit.fill,
                    height: screenHeight,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 80),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const WelcomeTextWidget(),
                                    kheight40,
                                    Textformfields(
                                      controller: emailController,
                                      labeltext: 'Email',
                                      icon: const Icon(Icons.email_outlined),
                                      validator: emailValidatorFunction,
                                    ),
                                    kheight20,
                                    Textformfields(
                                      obscureText: true,
                                      controller: passwordController,
                                      labeltext: 'Password',
                                      icon: const Icon(Icons.lock),
                                      validator: passeordValidationfunction,
                                    ),
                                    kheight10,
                                    const ForgetPasswordWidget(),
                                    kheight20,
                                    ElevatedButtonLogin(
                                      formKey: _formKey,
                                      onTap: () {
                                        authbloc.add(LoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
                                      },
                                    ),
                                    kheight20,
                                    GoogleElevatedButton(
                                      ontap: () {
                                        authbloc.add(GoogleSignInEvent());
                                      },
                                    ),
                                    kheight20,
                                    DontHaveAccountWidget(
                                      voidCallback: () {
                                        emailController.clear();
                                        passwordController.clear();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationScreen()));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
