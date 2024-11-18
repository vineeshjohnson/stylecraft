import 'package:finalproject/core/usecases/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc-related package
import 'package:flutter_stripe/flutter_stripe.dart';
import 'features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'firebase_options.dart';
import 'package:finalproject/core/usecases/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey = publishablekey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //adding routes

    Routes routes = Routes();

    //providing bloc on route widget

    return BlocProvider(
      create: (context) => AuthBlocBloc()..add(CheckLoginStatusEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: routes.routes,
      ),
    );
  }
}
