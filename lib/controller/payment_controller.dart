import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppers/model/utils/messenger.dart';

class PaymentController with ChangeNotifier {
  late final Razorpay _razorpay;

  PaymentController(){
    init();
  }

  void init() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Messenger.showSnackbar("Payment Successful \nOrder Id :- ${response.orderId}" +
        "\nPayement Id :- ${response.paymentId}" +
        "\nSignature :- ${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Messenger.showSnackbar("Payment Error Occurred \nError - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    Messenger.showSnackbar("External Wallet Successful \nWallet Name - ${response.walletName}");
  }

  void dispatchPayment(int amount, String email) {
    Map<String, dynamic> options = {
      "key" : "rzp_test_OFyZVomKRas5Ar",
      "amount" : amount*100,
      "currency": "INR",
      "name" : "Shoppers",
      "prefill" : {
        "email" : email
      }
    };

    try {
      _razorpay.open(options);
    } catch(e) {
      log(e.toString(), name: "Dispatch Method");
    }
  }
}
