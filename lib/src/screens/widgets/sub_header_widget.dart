import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:flutter/material.dart';

class SubHeaderWithTitle extends StatelessWidget {
  const SubHeaderWithTitle({
    super.key,
    required this.title,
    required this.press,
    required this.buttonText,
  });

  final String title;
  final String buttonText;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: AppFonts.headline2.copyWith(fontWeight: FontWeight.w600)),
        const Spacer(),
        TextButton(
          onPressed: () {
            press();
          },
          child: Text(
            buttonText,
            style: AppFonts.descriptionSmall.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
