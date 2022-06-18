import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppers/models/product.dart';

class ProductController extends ChangeNotifier {
  final firebaseInstance = FirebaseFirestore.instance;

  final List<Product> _products = [];
  final List<Product> _cartProducts = [];
  int _totalPrice = 0;

  List<Product> get products => _products;
  List<Product> get cartProducts => _cartProducts;
  int get totalPrice => _totalPrice;

  Future<bool> getProductData() async {
    _products.clear();
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
                productId: doc.id,
                description: doc['description'],
                imgUrl: doc["image"],
                price: doc["price"]
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

  void getCartItems(List<String>? productIds) {
    cartProducts.clear();
    _totalPrice = 0;
    for (var cartElementId in productIds!) {
      for (var product in _products) {
        if(product.productId == cartElementId) {
          cartProducts.add(product);
          _totalPrice += product.price;
        }
      }
    }
  }
}
