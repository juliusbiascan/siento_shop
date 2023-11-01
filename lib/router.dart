import 'package:siento_shop/features/account/screens/all_orders_screen.dart';
import 'package:siento_shop/features/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import 'package:siento_shop/models/order.dart';
import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/common/widgets/bottom_bar.dart';
import 'package:siento_shop/features/home/screens/home_screen.dart';
import 'package:siento_shop/features/auth/screens/auth_screen.dart';
import 'package:siento_shop/features/search/screens/search_screen.dart';
import 'package:siento_shop/features/address/screens/address_screen.dart';
import 'package:siento_shop/features/admin/screens/add_product_screen.dart';
import 'package:siento_shop/features/home/screens/category_deals_screen.dart';
import 'package:siento_shop/features/order_details/screens/order_details_screen.dart';
import 'package:siento_shop/features/product_details/screens/product_detail_screen.dart';

//all routes of the application
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // AuthScreen
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    // HomeScreen
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    // BottomBar
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    // AddProductScreen
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());

    // CategoryDealsScreen
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(category: category));

    // SearchScreen
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: searchQuery));

    // ProductDetailScreen
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(product: product));

    // CartScreen
    case CartScreen.routeName:
      // var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CartScreen());

    // AllOrdersScreen
    case AllOrdersScreen.routeName:
      var allOrders = routeSettings.arguments as List<Order>?;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AllOrdersScreen(allOrders: allOrders));

    // AddressScreen
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );

    // OrderDetailsScreen
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));

    // Screen does not exist
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(child: Text("Screen does not exist!")),
        ),
      );
  }
}
