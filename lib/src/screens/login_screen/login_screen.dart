import 'package:dicoding_food_deli/src/screens/navbar_screen/bottom_navbar.dart';
import 'package:dicoding_food_deli/src/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_page';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  late String email = 'user@dicoding.com';
  late String password = 'dicoding123';
  bool _isLoading = false;

  _checkLog(String? valueEmail, String? valuePassword) async {
    String textEmail = valueEmail!;
    String textPassword = valuePassword!;

    if (email == textEmail && password == textPassword) {
      Navigator.pushReplacementNamed(context, BottomNavbar.routeName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login success with $textEmail'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      _showAlertDialog(context, 'Email/Number or Password incorrect');
    }
  }

  _showAlertDialog(BuildContext context, String errorMessage) {
    Widget confirmButton = FloatingActionButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("OK"),
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage),
      actions: [confirmButton],
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: buildLoginWidget(),
              );
            } else if (constraints.maxWidth > 600) {
              return Center(
                child: SizedBox(
                  width: 400,
                  child: SingleChildScrollView(child: buildLoginWidget()),
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

  Widget buildLoginWidget() {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
          child: Image.asset('assets/img/logo/logo.png'),
        ),
        Text(
          "Proceed with your",
          style: AppFonts.headline2,
        ),
        Text(
          "Login",
          style: AppFonts.headline1,
        ),
        const SizedBox(height: 10),
        Text(
          "Enter your email or cellphone number and your password.",
          style: AppFonts.descriptionSmall.copyWith(color: kBaseGreyColor),
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 50,
          width: screenSize.width,
          child: TextField(
            controller: _emailController,
            autofocus: false,
            enableInteractiveSelection: true,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
              filled: true,
              fillColor: kWhiteColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: kBorderGreyColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kBorderGreyColor,
                ),
              ),
              hintText: "Email/Cellphone Number",
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: screenSize.width,
          child: TextField(
            controller: _passwordController,
            autofocus: false,
            obscureText: _isPasswordVisible,
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: kPalleteColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
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
              hintText: "Password",
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forgot Password",
              style: AppFonts.descriptionSmall.copyWith(color: kBaseGreyColor),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () async {
            if (_emailController.text.isEmpty ||
                _passwordController.text.isEmpty) {
              _showAlertDialog(context, 'Email or Password cannot be empty.');
              return;
            }
            setState(() {
              _isLoading = true;
            });
            await Future.delayed(const Duration(seconds: 2));
            await _checkLog(_emailController.text, _passwordController.text);

            setState(() {
              _isLoading = false;
            });
          },
          child: _isLoading
              ? CircularProgressIndicator(
                  color: kWhiteColor.withOpacity(0.5),
                )
              : Text(
                  'Login',
                  style: AppFonts.descriptionSmall.copyWith(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
        ),
        const SizedBox(height: 35),
        Row(
          children: [
            const Spacer(),
            const Expanded(child: Divider(color: kBaseGreyColor, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("Or continue with",
                  style: AppFonts.descriptionSmall
                      .copyWith(color: kBaseGreyColor)),
            ),
            const Expanded(child: Divider(color: kBaseGreyColor, thickness: 1)),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kBorderGreyColor),
                ),
                child: Image.asset(
                  'assets/img/logo/google-logo.png',
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kBorderGreyColor),
                ),
                child: Image.asset(
                  'assets/img/logo/meta-logo.png',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?', style: AppFonts.descriptionSmall),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              child: Text(
                'Sign up',
                style: AppFonts.descriptionSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
