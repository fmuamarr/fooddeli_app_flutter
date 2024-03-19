import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_list_screen.dart';
import 'package:dicoding_food_deli/src/screens/widgets/best_seller_card.dart';
import 'package:dicoding_food_deli/src/screens/widgets/restaurant_card.dart';
import 'package:dicoding_food_deli/src/screens/widgets/sub_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_food_deli/model/merchant_model.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/src/constants/fonts.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  static const routeName = '/home_page';
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomePageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BestSellerCard(
                firstSmallTitle: 'Weekly Best Seller',
                secondMediumTitle: 'Raja Burger\'s',
                thirdLargeTitle: 'BIG BURGERS',
                buttonText: 'Order Now!',
                onPressed: () {},
                imgCard: 'assets/img/burger-card.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SubHeaderWithTitle(
                  title: "Top Merchant", press: () {}, buttonText: 'See all>'),
            ),
            _buildMerchantList(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SubHeaderWithTitle(
                  title: "Recommendation",
                  press: () {
                    Navigator.pushNamed(
                        context, RestaurantListScreen.routeName);
                  },
                  buttonText: 'See all>'),
            ),
            SizedBox(height: 210, child: _buildRestaurantList()),
          ],
        ),
      ),
    );
  }

  AppBar _buildHomePageAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: kWhiteColor,
      title: const SizedBox(
        child: TextField(
          autofocus: false,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
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
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Divider(
          height: 1,
          color: kBorderGreyColor,
        ),
      ),
    );
  }

  Widget _buildMerchantList(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: merchantDataList.length,
        itemBuilder: (context, index) {
          final MerchantData merchant = merchantDataList[index];
          return _buildMerchantItem(context, merchant);
        },
      ),
    );
  }

  Widget _buildMerchantItem(BuildContext context, MerchantData merchant) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: kBGGreyColor),
              ),
              child: ClipOval(
                child: Image.asset(
                  merchant.merchantImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              merchant.merchantName,
              style: AppFonts.cardSmall.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.result.restaurants.length < 5
                ? state.result.restaurants.length
                : 5,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return HomeRestaurantCard(restaurant: restaurant);
            });
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
    });
  }
}
