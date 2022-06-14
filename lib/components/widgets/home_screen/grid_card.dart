import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppers/utils/theme/custom_theme.dart';

class GridCard extends StatelessWidget {
  final int index;
  final VoidCallback onPress;
  const GridCard({
  Key? key,
  required this.index,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index % 2 == 0 ? const EdgeInsets.only(left: 22) : const EdgeInsets.only(right: 22),
      decoration: CustomTheme.getCardDecoration(),
      child: GestureDetector(
        onTap: onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: SizedBox(
                  width: double.infinity,
                    child: CachedNetworkImage(
imageUrl: "https://images.unsplash.com/photo-1608231387042-66d1773070a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
                      fit: BoxFit.cover,
                    ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'title',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
