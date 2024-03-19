import 'package:dicoding_food_deli/provider/preferences_provider.dart';
import 'package:dicoding_food_deli/src/constants/colors.dart';
import 'package:dicoding_food_deli/provider/schedulling_provider.dart';
import 'package:dicoding_food_deli/src/screens/login_screen/login_screen.dart';
import 'package:dicoding_food_deli/src/screens/widgets/sub_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featuresList = [
      {'name': 'My Orders', 'icon': Icons.shopping_cart, 'trailing': false},
      {'name': 'Promos', 'icon': Icons.local_offer, 'trailing': false},
      {'name': 'Help center', 'icon': Icons.help, 'trailing': false},
      {'name': 'Terms & Conditions', 'icon': Icons.description},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GFListTile(
                  avatar: GFAvatar(
                    child: Image.network('https://i.pravatar.cc/300'),
                  ),
                  titleText: 'User',
                  subTitleText: 'Complete your Account profile',
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.grey),
                  margin: const EdgeInsets.all(5.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 10),
              _buildSubHeader(context, 'Setting'),
              _buildSchedulingNotificationTile(),
              _buildSubHeader(context, 'Support'),
              _buildFeaturesList(featuresList),
              _buildSubHeader(context, 'Others'),
              _buildLogoutTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SubHeaderWithTitle(title: title, press: () {}, buttonText: ""),
    );
  }

  Widget _buildSchedulingNotificationTile() {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return GFListTile(
          titleText: 'Scheduling Notification',
          avatar: const Icon(Icons.notifications_active),
          icon: Consumer<SchedulingProvider>(
            builder: (context, scheduled, _) {
              return Switch.adaptive(
                value: provider.isDailyRecommendationActive,
                onChanged: (value) async {
                  scheduled.scheduledRecommendation(value);
                  provider.enableDailyRecommendation(value);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFeaturesList(List<Map<String, dynamic>> featuresList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          const Divider(color: kBorderGreyColor),
      itemCount: featuresList.length,
      itemBuilder: (context, index) {
        final feature = featuresList[index];
        return GFListTile(
          avatar: Icon(feature['icon'] as IconData),
          titleText: feature['name'].toString(),
          onTap: () {},
          icon: const Icon(Icons.arrow_forward_ios_outlined, size: 16),
        );
      },
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return GFListTile(
      avatar: const Icon(Icons.logout_outlined),
      titleText: 'Logout',
      icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      onTap: () {
        _logout(context);
      },
    );
  }
}
