import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/components/widgets/custom_button.dart';

import '../../controller/data_controller.dart';
import '../../utils/theme/custom_theme.dart';

class ProductScreen extends StatefulWidget {
  final String price;
  final String title;
  final String imageUrl;
  final String desc;
  final String productId;


  const ProductScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.desc,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool addButtonLoad = false;

  void onAddToCart(BuildContext context) async {
    setState(() {
      addButtonLoad = true;
    });

    Provider.of<DataController>(context,listen: false).addToCart(widget.productId);
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
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 35,
                        child: Container(
                          decoration: const ShapeDecoration(
                              color: CustomTheme.YELLOW,
                              shape: CircleBorder(),
                              // shadows: [
                              //   BoxShadow(color: CustomTheme.GREY, blurRadius: 3, spreadRadius: 4, offset: Offset(1, 3))
                              // ]
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
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Center(child: Text(widget.title)),
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
                            child: Text(widget.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              children: [
                                const Text('MRP :'),
                                Text("\$ ${widget.price}"),
                              ],
                            ),
                          ),
                          CustomButton(
                              onPress: () => onAddToCart(context),
                              loading: addButtonLoad,
                              text: "Add to Cart",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                            child: Text(
                              "About the Items",
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ),
                          Text(
                            widget.desc,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 30,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    // boxShadow: [
                    //   BoxShadow(color: CustomTheme.GREY, blurRadius, spreadRadius: 1, offset: Offset(1, 3))
                    // ]
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
