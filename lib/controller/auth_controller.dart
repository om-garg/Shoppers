import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ApplicationLoginState { loggedOut, loggedIn }

class AuthController extends ChangeNotifier {
  User? user;

  ApplicationLoginState loginState = ApplicationLoginState.loggedOut;

  AuthController(){
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((userStatus) {
      if(userStatus != null) {
        loginState = ApplicationLoginState.loggedIn;
        user = userStatus;
      } else {
        loginState = ApplicationLoginState.loggedOut;
      }

      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password, void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      errorCallBack(e);
    } catch(e, s) {
      log(e.toString(), name: "SignUp Method");
      print(s);
    }
  }

  Future<void> signUp(String email, String password, void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      DocumentReference<Map<String, dynamic>> response1 = await FirebaseFirestore.instance.collection('userList').add({
        "user_auth_id" : userCredential.user!.uid,
        "user_id" : userCredential.user!.uid,
        "email" : email,
        "password" : password,
        "cartItems" : "",
      });

      FirebaseFirestore.instance.collection('userList').doc(response1.id).set({
        "user_auth_id" : userCredential.user!.uid,
        "user_id" : response1.id,
        "email" : email,
        "password" : password,
        "cartItems" : "",
      });

    } on FirebaseAuthException catch(e) {
      errorCallBack(e);
    } catch(e, s) {
      log(e.toString(), name: "SignUp Method");
      print(s);
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
