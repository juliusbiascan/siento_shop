import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/components/widgets/bottom_bar.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/components/widgets/custom_button.dart';
import 'package:siento_shop/pages/home/widgets/address_box.dart';
import 'package:siento_shop/pages/cart/widgets/cart_product.dart';
import 'package:siento_shop/pages/cart/widgets/cart_subtotal.dart';
import 'package:siento_shop/pages/search/screens/search_screen.dart';
import 'package:siento_shop/pages/address/screens/address_screen.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(num sum) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as num)
        .toList();
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Cart",
          dividerEndIndent: 280,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.height * 0.02),
            SizedBox(
              height: mq.height * 0.50,
              child: user.cart.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/no-orderss.png",
                            height: mq.height * .15),
                        const Text("No item in cart"),
                        SizedBox(height: mq.height * 0.02),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, BottomBar.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.deepPurpleAccent),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              child: Text(
                                "Keep Exploring",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: user.cart.length,
                      itemBuilder: (context, index) {
                        // return CartProdcut
                        return CartProduct(index: index);
                      }),
            ),
            SizedBox(height: mq.height * 0.02),
            Container(color: Colors.black12.withOpacity(0.08), height: 1),
            SizedBox(height: mq.height * 0.01),
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(mq.width * .025),
              child: CustomButton(
                  text:
                      "CHECKOUT (${user.cart.length} ${user.cart.length == 1 ? 'item' : 'items'})",
                  onTap: () =>
                      user.cart.isEmpty ? () {} : navigateToAddress(sum),
                  color:
                      user.cart.isEmpty ? Colors.grey[700] : Colors.grey[900]),
            ),
          ],
        ),
      ),
    );
  }
}
