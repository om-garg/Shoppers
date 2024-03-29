import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/controller/auth_controller.dart';
import 'package:shoppers/view/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool _loadingButton =  false;

    void signOutButtonPressed(){
      setState(() {
        _loadingButton = true;
      });
      Provider.of<AuthController>(context, listen: false).signOut();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Hi There',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CustomButton(
              onPress: signOutButtonPressed,
              loading: _loadingButton,
              text: 'SIGN OUT')
        ],
      ),
    );
  }
}
