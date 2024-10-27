import 'package:finalproject/core/usecases/common_widgets/sized_box.dart';
import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:finalproject/features/auth/presentation/pages/otpverification_screen/widgets/backto_login_button.dart';
import 'package:finalproject/features/auth/presentation/pages/otpverification_screen/widgets/email_verified_title.dart';
import 'package:finalproject/features/auth/presentation/pages/otpverification_screen/widgets/icon_success.dart';
import 'package:finalproject/features/auth/presentation/pages/otpverification_screen/widgets/sentence_widget.dart';
import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            emailVerifiedbackground,
            fit: BoxFit.fill,
            height: 800,

            // width: 500,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  kheight100,

                  // Success Icon
                  const IconSuccessWidget(),
                  kheight30,

                  // Email Verified Text
                  const EmailVerifiedTitleWidget(),
                  kheight20,

                  // Email instruction
                  SentenceWidget(email: email),
                  kheight40,

                  const BackToLoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
