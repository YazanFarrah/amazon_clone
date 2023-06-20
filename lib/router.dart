import 'package:amazone_clone/common/widgets/bottom_bar.dart';
import 'package:amazone_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazone_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazone_clone/features/home/screens/home_screen.dart';
import 'package:amazone_clone/features/product_details/product_details_screen.dart';
import 'package:amazone_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import 'features/auth/auth_screen.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(
        builder: (builder) => const AuthScreen(),
      );
    case HomeScreen.routName:
      return MaterialPageRoute(
        builder: (builder) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (builder) => const BottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (builder) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (builder) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductScreenDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (builder) => ProductScreenDetails(
          product: product,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (builder) => const Scaffold(
                body: Center(
                  child: Text('Screen doesn\'t exist'),
                ),
              ));
  }
}
