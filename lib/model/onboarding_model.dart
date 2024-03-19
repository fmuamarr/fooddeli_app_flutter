class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> onBoardData = [
  OnBoard(
    image: 'assets/img/onboarding-1.png',
    title: 'FAST DELIVERY',
    description:
        'Experience unmatched speed with our top-notch food delivery service. Your satisfaction is our priority, guaranteeing your order arrives promptly. Rely on us to be the quickest option for all your food cravings. ',
  ),
  OnBoard(
    image: 'assets/img/onboarding-2.png',
    title: 'ENSURING FOOD SAFETY',
    description:
        'Rest assured, your food is in the safest hands with our expert drivers. Our dedicated team ensures your order is delivered securely, preserving its freshness from kitchen to your doorstep. Trust us to safeguard your meal every step of the way.',
  ),
  OnBoard(
    image: 'assets/img/onboarding-3.png',
    title: 'CASH ON DELIVERY',
    description:
        'For cash people, don\'t worry we have a Cash On Delivery option for you. You pay when you get your order!',
  ),
];
