import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/controller/auth_controller.dart';
import 'package:shoppers/model/utils/data/login_data.dart';
import 'package:shoppers/model/utils/theme/custom_theme.dart';
import 'package:shoppers/view/widgets/custom_button.dart';
import 'package:shoppers/view/widgets/login_screen/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loadingButton = false;

  Map<String, String> data = {

  };

  _LoginScreenState(){
    data = LoginData.signIn;
  }

  loginError(FirebaseAuthException e) {
    if(e.message != '') {
      setState(() {
        _loadingButton = false;
      });
    } else {
      log(e.toString(), name: "Login Error");
      log(e.message.toString(), name: "Login Error Message");
    }
  }

  loginButtonPressed(){
    setState(() {
      _loadingButton = true;
    });

    AuthController loginState = Provider.of<AuthController>(context, listen: false);
    if(mapEquals(data, LoginData.signIn)) {
      loginState.signIn(_emailController.text, _passwordController.text, loginError);
    } else {
      loginState.signUp(_emailController.text, _passwordController.text, loginError);
    }
  }

  void switchLogin(){
    setState(() {
      if(mapEquals(data, LoginData.signIn)) {
        data = LoginData.signUp;
      } else {
        data = LoginData.signIn;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0,bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      data['heading'] as String,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    data['subHeading'] as String,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            model(data, _emailController, _passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: switchLogin,
                    child: Text(
                      data['footer'] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  model(Map<String, String> data, TextEditingController emailController, TextEditingController passwordController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 56),
      decoration: CustomTheme.getCardDecoration(),
      child: Column(
        children: [
          CustomTextField(
              textEditingController: _emailController,
              icon: Icons.person_outlined,
              label: "Your email address",
              placeholder: "email@address.com",
          ),
          CustomTextField(
            textEditingController: _passwordController,
            icon: Icons.lock_outlined,
            label: "Password",
            placeholder: "password",
          ),
          CustomButton(
              onPress: loginButtonPressed,
              loading: _loadingButton,
              text: data['label'] as String,
          )
        ],
      ),
    );
  }
}
