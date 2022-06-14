import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/firebase_options.dart';
import 'package:shoppers/screens/checkout_screen/checkout_screen.dart';
import 'package:shoppers/screens/home_screen/home_screen.dart';
import 'package:shoppers/screens/login_screen/login_screen.dart';
import 'package:shoppers/screens/profile_screen/profile_screen.dart';
import 'package:shoppers/utils/services/auth_controller.dart';
import 'package:shoppers/utils/theme/custom_theme.dart';

Future<void> main() async {
  // Firebase Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Stripe Setup
  final String response =
      await rootBundle.loadString("assets/config/stripe.json");
  final data = await json.decode(response);
  Stripe.publishableKey = data['publishableKey'];

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginState(),
      builder: (context, _) => Consumer<LoginState>(
        builder: (context, value, _) {
          Widget child;
          switch (value.loginState) {
            case ApplicationLoginState.loggedOut:
              child = const LoginScreen();
              break;
            case ApplicationLoginState.loggedIn:
              child = const MyApp();
              break;
            default:
              child = const LoginScreen();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.getTheme(),
            home: child,
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Shoppers"),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: CustomTheme.CARD_SHADOW,
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          ),
          child: const TabBar(
              padding: EdgeInsets.symmetric(vertical: 10),
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.shopping_cart),
                )
              ]),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            ProfileScreen(),
            CheckOutScreen()
          ],
        ),
      ),
    );
  }
}
