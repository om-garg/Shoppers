import 'package:flutter/material.dart';
import 'package:shoppers/components/widgets/custom_button.dart';

import '../../components/widgets/checkout_screen/list_card.dart';
import '../../utils/theme/custom_theme.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final cartItems = ["1", "2", "3", "4"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // physics: const BounceScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 30),
              itemCount: cartItems.length,
              itemBuilder: (context, index){
              return const ListCard();
              }
          ),
        ),
        priceFooter(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: CustomButton(
            text: "CHECKOUT",
            onPress: (){},
            loading: false,
          ),
        )
      ],
    );
  }
  priceFooter() {
    return Padding(
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
                  "\$ price",
                  style: Theme.of(context).textTheme.headlineSmall,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
