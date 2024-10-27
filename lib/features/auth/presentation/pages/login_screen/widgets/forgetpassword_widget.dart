import 'package:flutter/material.dart';

import '../../forgetpassword_screen/forgetpassword_screen.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
