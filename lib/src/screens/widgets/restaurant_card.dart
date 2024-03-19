import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_item_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRestaurantCard extends StatelessWidget {
  const HomeRestaurantCard({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final restaurantDetailProvider =
        Provider.of<RestaurantDetailProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        restaurantDetailProvider.loadRestaurantDetail(restaurant.id);
        Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
            arguments: restaurant);
      },
      child: Card(
        color: kWhiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: kBGGreyColor,
            width: 1.5,
          ),
        ),
        child: SizedBox(
          height: 200,
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kBGGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  width: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Placeholder(
                                fallbackWidth: 120,
                                fallbackHeight: 100,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 5,
                ),
                child: Text(
                  restaurant.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.descriptionSmall
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 2.5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(restaurant.city, style: AppFonts.cardSmallLight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const ListRestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final restaurantDetailProvider =
        Provider.of<RestaurantDetailProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        restaurantDetailProvider.loadRestaurantDetail(restaurant.id);
        Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
            arguments: restaurant);
      },
      child: Card(
        color: kWhiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: kBorderGreyColor.withOpacity(0.5), width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_city, size: 16),
                        const SizedBox(width: 4),
                        Text(restaurant.city),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.yellow),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
