import 'package:flutter/material.dart';
import 'package:shoppers/utils/theme/custom_theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final TextEditingController textEditingController;
  final bool password;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.icon,
    required this.label,
    this.password = false,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 20),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 56,
            child: TextField(
              controller: textEditingController,
              obscureText: password,
              enableSuggestions: !password,
              autocorrect: !password,
              decoration: InputDecoration(
                prefix: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 22.0, end: 20),
                  child: Icon(
                    icon,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                filled: true,
                hintText: placeholder,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: CustomTheme.GREY),
              ),
            ),
          )
        ],
      ),
    );
  }
}
