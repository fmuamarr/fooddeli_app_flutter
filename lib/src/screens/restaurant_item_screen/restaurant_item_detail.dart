import 'package:dicoding_food_deli/model/restaurant_detail_model.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/provider/database_provider.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:dicoding_food_deli/src/screens/widgets/sub_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            if (provider.state == ResultState.hasData) {
              return Row(
                children: [
                  Expanded(
                    child: Text(provider.detailResult.restaurant.name),
                  ),
                  Consumer<DatabaseProvider>(
                    builder: (context, value, child) {
                      return FutureBuilder(
                        future: value
                            .isFavorited(provider.detailResult.restaurant.id),
                        builder: (context, snapshot) {
                          var isFavorited = snapshot.data ?? false;
                          return IconButton(
                            icon: isFavorited
                                ? const Icon(
                                    Icons.favorite,
                                    color: kPrimaryColor,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                            onPressed: () {
                              if (isFavorited) {
                                value.removeFavorite(restaurant.id);
                              } else {
                                value.addFavorites(restaurant);
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            final RestaurantDetailResult restaurantDetail =
                provider.detailResult;
            return SingleChildScrollView(
              child: _buildRestaurantDetailContent(context, restaurantDetail),
            );
          } else if (provider.state == ResultState.noData) {
            return const Center(
              child: Text('No Data Available'),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildRestaurantDetailContent(
      BuildContext context, RestaurantDetailResult restaurant) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 110,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.restaurant.pictureId}',
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.restaurant.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.headline2.copyWith(fontSize: 20),
                  ),
                  Text(
                    restaurant.restaurant.categories
                        .map((cat) => cat.name)
                        .toList()
                        .join(', '),
                    style: AppFonts.descriptionSmall
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: kBGGreyColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5)),
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconAndButtonWidget(
                buttonFunction: () {
                  Navigator.pushNamed(context, ReviewScreen.routeName,
                      arguments: restaurant.restaurant.customerReviews);
                },
                icon: Icons.star,
                iconColor: Colors.yellow,
                text: restaurant.restaurant.rating.toString(),
                textButton: "See Review",
              ),
              const VerticalDivider(color: kBorderGreyColor, thickness: 1),
              IconAndButtonWidget(
                buttonFunction: () {},
                icon: Icons.location_on,
                iconColor: Colors.red,
                text: restaurant.restaurant.city,
                textButton: "Check",
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            restaurant.restaurant.description,
            style: AppFonts.descriptionSmall,
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:
              SubHeaderWithTitle(title: "Food", press: () {}, buttonText: ""),
        ),
        _buildFoodItem(context, restaurant.restaurant),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:
              SubHeaderWithTitle(title: "Drink", press: () {}, buttonText: ""),
        ),
        _buildDrinkItem(context, restaurant.restaurant),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SubHeaderWithTitle(
            title: "Reviews",
            press: () {
              Navigator.pushNamed(context, ReviewScreen.routeName,
                  arguments: restaurant.restaurant.customerReviews);
            },
            buttonText: "See All Reviews",
          ),
        ),
        _buildReviews(context, restaurant.restaurant.customerReviews),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildReviews(BuildContext context, List<CustomerReview> reviews) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SizedBox(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: kBorderGreyColor.withOpacity(0.5))),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.review,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        review.name,
                        style: AppFonts.cardSmall.copyWith(fontSize: 14),
                      ),
                      Text(
                        review.date,
                        style: AppFonts.cardSmallLight.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodItem(BuildContext context, RestaurantDetail restaurant) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: _buildItemMenu(context, restaurant,
          'https://source.unsplash.com/featured/?food', restaurant.menus.foods),
    );
  }

  Widget _buildDrinkItem(BuildContext context, RestaurantDetail restaurant) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: _buildItemMenu(
          context,
          restaurant,
          'https://source.unsplash.com/featured/?drink',
          restaurant.menus.drinks),
    );
  }

  Widget _buildItemMenu(BuildContext context, RestaurantDetail restaurant,
      String imageUrl, List menuItems) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        menuItems.length,
        (index) {
          String menuName = menuItems[index].name;
          double price = 10000 + ((index + 1) * 1000);
          return Card(
            color: kBGGreyColor.withOpacity(0.5),
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    menuName,
                    maxLines: 2,
                    style: AppFonts.cardSmall.copyWith(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text('Rp. ${price.toStringAsFixed(0)}',
                      style: AppFonts.descriptionSmall),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class IconAndButtonWidget extends StatelessWidget {
  const IconAndButtonWidget({
    super.key,
    required this.buttonFunction,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textButton,
  });

  final Function buttonFunction;
  final IconData icon;
  final Color iconColor;
  final String text, textButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 4),
              Text(text, style: AppFonts.headline2.copyWith(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(
            height: 35,
            child: TextButton(
              onPressed: () {
                buttonFunction();
              },
              child: Text(
                textButton,
              ),
            )),
      ],
    );
  }
}

class ReviewScreen extends StatelessWidget {
  static const routeName = '/review_page';
  final List<CustomerReview> reviews;

  const ReviewScreen({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Reviews"),
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Column(
            children: [
              ListTile(
                title: Text(review.review),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(review.name),
                    Text(review.date),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: kBorderGreyColor.withOpacity(0.5),
              ),
            ],
          );
        },
      ),
    );
  }
}
