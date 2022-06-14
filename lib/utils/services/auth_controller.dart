import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ApplicationLoginState { loggedOut, loggedIn }

class LoginState extends ChangeNotifier {
  User? user;

  ApplicationLoginState loginState = ApplicationLoginState.loggedOut;

  LoginState(){
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
      if (kDebugMode) {
        print(s);
      }
    }
  }

  Future<void> signUp(String email, String password, void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      DocumentReference<Map<String, dynamic>> response = await FirebaseFirestore.instance.collection('userList').add({
        "user_id" : userCredential.user!.uid,
        "email" : email,
        "password" : password
      });

      log(response.id.toString(), name: "Add user to firebase");

      // Stripe user create
    } on FirebaseAuthException catch(e) {
      errorCallBack(e);
    } catch(e, s) {
      log(e.toString(), name: "SignUp Method");
      if (kDebugMode) {
        print(s);
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
