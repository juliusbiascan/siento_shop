import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/pages/cart/screens/cart_screen.dart';
import 'package:siento_shop/pages/product_details/services/product_detail_services.dart';

class WishListProduct extends StatefulWidget {
  final int index;
  const WishListProduct({required this.index, super.key});

  @override
  State<WishListProduct> createState() => _WishListProductState();
}

class _WishListProductState extends State<WishListProduct> {
  ProductDetailServices productDetailServices = ProductDetailServices();

  @override
  Widget build(BuildContext context) {
    // fetching the particular product
    final productWishList = context.watch<UserProvider>().user.wishList == null
        ? []
        : context.watch<UserProvider>().user.wishList![widget.index];
    final product = Product.fromJson(productWishList['product']);
    Size mq = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: mq.width * .025),
          child: Row(
            children: [
              // image
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: mq.width * .25,
                width: mq.width * .25,
              ),
              // description
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mq.width * .57,
                    padding: EdgeInsets.only(
                        left: mq.width * .025, top: mq.width * .0125),
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: mq.width * .57,
                    padding: EdgeInsets.only(
                        left: mq.width * .025, top: mq.width * .0125),
                    child: Text(
                      "PHP ${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      maxLines: 2,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (product.quantity == 0) {
                        showSnackBar(
                            context: context, text: "Product out of stock");
                      } else {
                        productDetailServices.addToCart(
                            context: context, product: product);
                        showSnackBar(
                            context: context,
                            text: "Added to cart",
                            actionLabel: "View Cart",
                            onTapFunction: () {
                              Navigator.pushNamed(
                                  context, CartScreen.routeName);
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: Size(mq.width * 0.3, 20),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      "Add to cart",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
