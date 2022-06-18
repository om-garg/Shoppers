import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppers/models/product.dart';
import 'package:shoppers/models/user.dart';
import 'auth_controller.dart';

class DataController extends ChangeNotifier {
  final firebaseInstance = FirebaseFirestore.instance;

  AuthController authController = AuthController();

  UserData? _userData;

  UserData? get userData => _userData;

  Future<void> getUserData() async {
    try {
      var response = await firebaseInstance
          .collection("userList")
          .where("user_id", isEqualTo: authController.user?.uid)
          .get();

      if (response.docs.isNotEmpty) {
        UserData userData = UserData(
            password: response.docs[0]["password"],
            email: response.docs[0]["email"],
            cartProductIds: response.docs[0]["cartItems"].length > 0
                ? response.docs[0]["cartItems"].split(",")
                : [],
            userId: response.docs[0]["user_id"]);
        _userData = userData;
      }
    } catch (e) {
      log(e.toString(), name: "Get User Data Error");
    }
  }

  Future<void> addToCart(String productId) async {
    _userData?.cartProductIds.add(productId);

    try {
      await firebaseInstance
          .collection('userList')
          .doc(_userData?.userId)
          .update({
        "cartItems": _userData?.cartProductIds.length == 1 ? productId : _userData?.cartProductIds.join(",")
      });

      print(_userData?.cartProductIds.length);
    } catch (e) {
      log(e.toString(), name: "Add to Cart Error");
    }
  }
}
