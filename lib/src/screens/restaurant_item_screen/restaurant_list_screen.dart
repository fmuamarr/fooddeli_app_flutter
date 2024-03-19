import 'package:dicoding_food_deli/provider/database_provider.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_item_detail.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:provider/provider.dart';

class RestaurantListScreen extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: _buildRestaurantList(),
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CustomCard(
                restaurant: restaurant,
                showFavoriteButton: false,
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('Unknown Error'),
            ),
          );
        }
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  final Restaurant restaurant;
  final bool showFavoriteButton;

  const CustomCard({
    super.key,
    required this.restaurant,
    this.showFavoriteButton = true,
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
              if (showFavoriteButton)
                Consumer<DatabaseProvider>(
                  builder: (context, value, child) {
                    return FutureBuilder(
                      future: value.isFavorited(restaurant.id),
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
          ),
        ),
      ),
    );
  }
}
