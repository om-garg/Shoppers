import 'package:flutter/material.dart';
import 'package:shoppers/screens/product/product_screen.dart';

import '../../components/widgets/home_screen/grid_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = ["1", "2", "3", "4"];

  @override
  Widget build(BuildContext context) {
    onCardPress() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
    }
    return Container(
      child: GridView.builder(
        itemCount: data.length,
          padding: const EdgeInsets.symmetric(vertical: 30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30
          ),
          itemBuilder: (BuildContext context, int index) {
          return GridCard(index: index, onPress: onCardPress);
          }
      )
    );
  }
}
