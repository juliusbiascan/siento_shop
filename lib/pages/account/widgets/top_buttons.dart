// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:siento_shop/pages/home/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:siento_shop/pages/cart/screens/cart_screen.dart';
import 'package:siento_shop/pages/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  // final List<String> buttonNames = [
  //   "Your Orders",
  //   "Turn Seller",
  //   "Log out",
  //   "Your Wishlist",
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
                text: "Cart",
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                }),
            AccountButton(
                text: "Your Wishlist",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WishListScreen()));
                }),
          ],
        ),
      ],
    );
  }
}
