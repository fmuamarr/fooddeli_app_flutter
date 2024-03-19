import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup_page';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Image.asset('assets/img/logo/logo.png'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: BuildSignUpWidget(
                  screenSize: screenSize,
                ),
              );
            } else if (constraints.maxWidth > 600) {
              return Center(
                child: SizedBox(
                  width: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BuildSignUpWidget(
                          screenSize: screenSize,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            }
            throw {
              const Text('Something bad happened.'),
            };
          },
        ),
      ),
    );
  }
}

class BuildSignUpWidget extends StatelessWidget {
  const BuildSignUpWidget({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign Up",
          style: AppFonts.headline1,
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Create your ',
            style: AppFonts.descriptionSmall.copyWith(color: kBaseGreyColor),
            children: <TextSpan>[
              TextSpan(
                text: 'Food Deli',
                style: AppFonts.descriptionSmall.copyWith(
                  color: kBaseGreyColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const TextSpan(text: ' account and ready for your first order!'),
            ],
          ),
        ),
        const SizedBox(height: 25),
        TextFieldSignUp(
            screenSize: screenSize,
            hintText: "Full Name",
            prefixIcon: const Icon(Icons.person_outline)),
        TextFieldSignUp(
            screenSize: screenSize,
            hintText: "Email",
            prefixIcon: const Icon(Icons.mail_outline)),
        TextFieldSignUp(
            screenSize: screenSize,
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock_outline)),
        TextFieldSignUp(
            screenSize: screenSize,
            hintText: "Confirm Password",
            prefixIcon: const Icon(Icons.lock_outline)),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () {},
          child: Text(
            'Sign Up',
            style: AppFonts.descriptionSmall.copyWith(
              color: kWhiteColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldSignUp extends StatelessWidget {
  const TextFieldSignUp({
    super.key,
    required this.screenSize,
    required this.hintText,
    required this.prefixIcon,
  });

  final Size screenSize;
  final String hintText;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 50,
        width: screenSize.width,
        child: TextField(
          autofocus: false,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
            filled: true,
            fillColor: kWhiteColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kBorderGreyColor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kBorderGreyColor,
              ),
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
