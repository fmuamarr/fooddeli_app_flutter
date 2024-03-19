import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String? _lastSearchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchAppBar(context),
      body: _buildRestaurantSearch(context),
    );
  }

  AppBar _buildSearchAppBar(BuildContext context) {
    final restaurantSearchProvider =
        Provider.of<RestaurantSearchProvider>(context, listen: false);
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: kWhiteColor,
      title: SizedBox(
        child: TextField(
          autofocus: false,
          enableInteractiveSelection: true,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
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
            hintText: "Search...",
          ),
          onSubmitted: (value) {
            _lastSearchQuery = value;
            restaurantSearchProvider.loadRestaurantSearch(value);
          },
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Divider(
          height: 1,
          color: kBorderGreyColor,
        ),
      ),
    );
  }

  Widget _buildRestaurantSearch(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (_lastSearchQuery == null) {
          return const Center(
            child: Text(""),
          );
        } else if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.searchResult.founded,
            itemBuilder: (context, index) {
              var restaurant = state.searchResult.restaurants[index];
              return CustomCard(
                restaurant: restaurant,
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

  @override
  void dispose() {
    _lastSearchQuery = null;
    super.dispose();
  }
}
