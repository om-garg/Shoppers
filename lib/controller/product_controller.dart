import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppers/models/product.dart';

class ProductController extends ChangeNotifier {
  final firebaseInstance = FirebaseFirestore.instance;

  final List<Product> _products = [];

  List<Product> get products => _products;

  Future<bool> getProductData() async {
    try {
      await firebaseInstance
              .collection('product')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              Product product = Product(
                category: doc["category"],
                title: doc['title'],
                id: doc['id'],
                productId: '',
                description: doc['description'],
                imgUrl: doc["image"],
                price: doc["price"],
              );

              _products.add(product);
            }
          });

      return true;

    } catch (e) {
      log(e.toString(), name: "Get Product Data");
      return false;
    }
  }

  Future<void> fetchProducts() async {
    await getProductData();

    notifyListeners();
  }
}
