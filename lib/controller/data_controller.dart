import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth_controller.dart';

class DataController extends ChangeNotifier {
  final firebaseInstance = FirebaseFirestore.instance;

  AuthController authController = AuthController();

  Future<void> getUserData() async {
    try {
      Future<QuerySnapshot<Map<String, dynamic>>> response =
          firebaseInstance
              .collection('product')
              .where('user_Id', isEqualTo: authController.user?.uid)
              .get();

      log(response.toString(), name: "Get User Data");
    } catch (e) {
      log(e.toString(), name: "Get User Data");
    }
  }
}
