// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/components/widgets/bottom_bar.dart';
import 'package:siento_shop/pages/home/screens/wish_list_product.dart';

class WishListScreen extends StatefulWidget {
  // List<Product>? wishList;
  const WishListScreen({
    Key? key,
    // this.wishList,
  }) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    // List<dynamic>? wishList = userProvider.user.wishList;
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          title: "Your Wishlist",
          onClickSearchNavigateTo: const MySearchScreen()),
      body: Container(
        alignment: Alignment.center,
        // color: Colors.redAccent,
        padding: EdgeInsets.only(top: mq.height * .02),
        // height: mq.height * 0.55,
        child: user.wishList!.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/no-orderss.png",
                    height: mq.height * .25,
                  ),
                  const Text(
                    "Oops, no item in wishList",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: mq.height * .01),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, BottomBar.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent),
                      child: const Text(
                        "Add a product now",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                for (int index = 0; index < user.wishList!.length; index++)
                  WishListProduct(index: index)
              ]),
      ),
    );
  }
}
