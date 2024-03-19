import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:dicoding_food_deli/src/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:dicoding_food_deli/model/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onboard_page';

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  bool isLastPage = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onButtonNextTapped(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showLogin', true);

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 450) {
              return _buildContentColumn();
            } else {
              return _buildContentRow();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContentColumn() {
    return Column(
      children: [
        Expanded(
          child: _buildPageView(),
        ),
        _buildBottomWidgets(),
      ],
    );
  }

  Widget _buildContentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: _buildPageView(),
        ),
        Expanded(flex: 1, child: _buildBottomWidgets()),
      ],
    );
  }

  Widget _buildPageView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return PageView.builder(
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == onBoardData.length - 1;
            });
          },
          itemCount: onBoardData.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            final OnBoard onBoardList = onBoardData[index];
            return OnBoardingWidget(
              image: onBoardList.image,
              title: onBoardList.title,
              description: onBoardList.description,
            );
          },
        );
      },
    );
  }

  Widget _buildBottomWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: kPrimaryColor,
              ),
              child: const Icon(
                Icons.arrow_forward_sharp,
                color: kWhiteColor,
                size: 35,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  onButtonNextTapped(context);
                },
                child: Text(
                  isLastPage ? 'Get Started >' : 'Skip >',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: kBaseGreyColor,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 40),
          child: SmoothPageIndicator(
            controller: _pageController,
            count: onBoardData.length,
            effect: const WormEffect(
              dotColor: kPalleteColor,
              activeDotColor: kBaseGreyColor,
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thinUnderground,
            ),
          ),
        ),
      ],
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 40 / 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              image,
              alignment: Alignment.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
          child: Text(
            title,
            style: AppFonts.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            description,
            style: AppFonts.descriptionSmall.copyWith(color: kBaseGreyColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
