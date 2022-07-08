import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/controller/data_controller.dart';
import 'package:shoppers/controller/product_controller.dart';
import 'package:shoppers/view/screens/product/product_screen.dart';
import 'package:shoppers/view/widgets/home_screen/grid_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    await Provider.of<ProductController>(context, listen: false)
        .fetchProducts();
    Provider.of<ProductController>(context,listen: false).getCartItems(context.read<DataController>().userData?.cartProductIds);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (context, value, child) {
      return GridView.builder(
          itemCount: value.products.length,
          padding: const EdgeInsets.symmetric(vertical: 30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 30, crossAxisSpacing: 30),
          itemBuilder: (BuildContext context, int index) {
            return GridCard(
              index: index,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              price: value.products[index].price.toString(),
                              desc: value.products[index].description,
                              imageUrl: value.products[index].imgUrl,
                              title: value.products[index].title,
                          productId: value.products[index].productId,
                            )));
              },
              price: value.products[index].price.toString(),
              title: value.products[index].title,
              imageUrl: value.products[index].imgUrl,
            );
          });
    });
  }
}
