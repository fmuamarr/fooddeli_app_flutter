import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:flutter/material.dart';

class BestSellerCard extends StatelessWidget {
  final String firstSmallTitle,
      secondMediumTitle,
      thirdLargeTitle,
      buttonText,
      imgCard;
  final Function onPressed;

  const BestSellerCard({
    super.key,
    required this.firstSmallTitle,
    required this.secondMediumTitle,
    required this.thirdLargeTitle,
    required this.buttonText,
    required this.imgCard,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: IntrinsicWidth(
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFDA294),
                        Color(0xFFFA7463),
                        Color(0xFFF54323),
                        Color(0xFFF54323),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          firstSmallTitle,
                          style:
                              AppFonts.cardSmall.copyWith(color: kWhiteColor),
                        ),
                        Text(
                          secondMediumTitle,
                          style: AppFonts.cardSmall
                              .copyWith(fontSize: 16, color: kWhiteColor),
                        ),
                        Text(
                          thirdLargeTitle,
                          style: AppFonts.cardBig.copyWith(color: kWhiteColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            onPressed;
                          },
                          child: Text(
                            buttonText,
                            style: AppFonts.cardSmall
                                .copyWith(fontSize: 14, color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  imgCard,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
