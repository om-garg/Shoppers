import 'package:flutter/material.dart';
import 'package:shoppers/model/utils/theme/custom_theme.dart';

import 'loader.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool loading;
  const CustomButton({
  Key? key,
    required this.onPress,
    required this.loading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(35),
  color: CustomTheme.YELLOW,
  boxShadow: CustomTheme.BUTTON_SHADOW
),
      child: MaterialButton(
        onPressed: loading ? null : onPress,
        child: loading
        ? const Loader()
        : Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
