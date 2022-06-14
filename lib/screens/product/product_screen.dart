import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppers/components/widgets/custom_button.dart';

import '../../utils/theme/custom_theme.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool addButtonLoad = false;

  void onAddToCart() async {
    setState(() {
      addButtonLoad = true;
    });

    // Add to cart
    setState(() {
      addButtonLoad = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: "https://images.unsplash.com/photo-1608231387042-66d1773070a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: 35,
                        child: Container(
                          decoration: const ShapeDecoration(
                              color: CustomTheme.YELLOW,
                              shape: CircleBorder(),
                              shadows: [
                                BoxShadow(color: CustomTheme.GREY, blurRadius: 3, spreadRadius: 4, offset: Offset(1, 3))
                              ]
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.share),
                            color: Colors.black,
                            onPressed: (){},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineLarge!,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: Text('title'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(),
                              )
                            ],
                          ),

                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineLarge!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 22.0),
                            child: Text('title'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              children: [
                                Text('MRP :'),
                                Text("\$ price"),
                              ],
                            ),
                          ),
                          CustomButton(
                              onPress: onAddToCart,
                              loading: addButtonLoad,
                              text: "Add to Cart",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              "About the Items",
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "The item description",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                          ),
                        ],
                      ),

                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 30,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(color: CustomTheme.GREY, blurRadius: 3, spreadRadius: 4, offset: Offset(1, 3))
                    ]
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
