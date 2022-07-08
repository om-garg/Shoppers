import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/controller/data_controller.dart';
import 'package:shoppers/controller/payment_controller.dart';
import 'package:shoppers/controller/product_controller.dart';
import 'package:shoppers/model/utils/theme/custom_theme.dart';
import 'package:shoppers/view/widgets/checkout_screen/list_card.dart';
import 'package:shoppers/view/widgets/custom_button.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context
    //     .read<ProductController>()
    //     .getCartItems(context.watch<DataController>().userData?.cartProductIds);


    final List cartItems = context.watch<ProductController>().cartProducts;

    void dispatchPayment(String? email, int amount) {
      context.read<PaymentController>().dispatchPayment(amount, email!);
    }

    return Column(
      children: [
        Expanded(
          flex: 7,
          child: cartItems.isEmpty
              ? Center(
                child: Text(
                    "The cart is empty",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
              )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListCard(
                      price: cartItems[index].price.toString(),
                      imgUrl: cartItems[index].imgUrl,
                      title: cartItems[index].title,
                    );
                  }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: CustomTheme.GREY,
                thickness: 2,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Total :",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      "\$ ${context.watch<ProductController>().totalPrice.toString()}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: CustomButton(
            text: "CHECKOUT",
            onPress: () => dispatchPayment(context.read<DataController>().userData?.email, context.read<ProductController>().totalPrice),
            loading: false,
          ),
        )
      ],
    );
  }
}
