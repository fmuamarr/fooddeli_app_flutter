import 'package:dicoding_food_deli/provider/database_provider.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  restaurant: provider.favorites[index],
                  showFavoriteButton: true,
                );
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}
