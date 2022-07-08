import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/controller/auth_controller.dart';
import 'package:shoppers/controller/data_controller.dart';
import 'package:shoppers/controller/payment_controller.dart';
import 'package:shoppers/controller/product_controller.dart';
import 'package:shoppers/firebase_options.dart';
import 'package:shoppers/model/utils/theme/custom_theme.dart';
import 'package:shoppers/view/screens/checkout_screen/checkout_screen.dart';
import 'package:shoppers/view/screens/home_screen/home_screen.dart';
import 'package:shoppers/view/screens/login_screen/login_screen.dart';
import 'package:shoppers/view/screens/profile_screen/profile_screen.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // Firebase Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => DataController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => PaymentController()),
      ],
      builder: (context, _) => Consumer<AuthController>(
        builder: (context, value, _) {
          Widget child;
          switch (value.loginState) {
            case ApplicationLoginState.loggedOut:
              child = const LoginScreen();
              break;
            case ApplicationLoginState.loggedIn:
              child = const MyApp();
              Provider.of<DataController>(context).getUserData();
              break;
            default:
              child = const LoginScreen();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.getTheme(),
            home: child,
            navigatorKey: navigationKey,
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
