import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/search/screens/search_screen.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:siento_shop/pages/product_details/services/product_detail_services.dart';
import 'package:expandable_text/expandable_text.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-details';
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailServices productDetailServices = ProductDetailServices();

  num myRating = 0.0;
  double avgRating = 0.0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0.0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      //showing our own rating in the product details page
      //overall rating will be avgRating but
      //when we see a particular product we will be able to see
      //our given rating, i.e.  myRating
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailServices.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    bool isProductAvailable = widget.product.quantity == 0;
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context, onClickSearchNavigateTo: const MySearchScreen()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .03)
              .copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: mq.height * .3,
                        child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemCount: widget.product.images.length,
                            //physics: const PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // print("............index = $index");
                              return Builder(
                                builder: (context) => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mq.height * .05),
                                  child: Image.network(
                                      widget.product.images[index],
                                      fit: BoxFit.contain,
                                      height: mq.width * .3),
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.product.images.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showSnackBar(
                          context: context,
                          text:
                              "Share feature yet to be implemented using deep links");
                    },
                    icon: const Icon(Icons.share),
                  )
                ],
              ),
              SizedBox(height: mq.height * .02),

              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w200),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "PHP ${widget.product.price.toStringAsFixed(2)}  ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      // color: Colors.,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: mq.height * .01),
              const Text("About the Product",
                  style: TextStyle(fontWeight: FontWeight.w700)),

              ExpandableText(
                widget.product.description,
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 1,
                linkColor: Colors.blue,
                style: TextStyle(color: Colors.grey.shade500),
              ),

              SizedBox(height: mq.height * .01),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("${avgRating.toStringAsFixed(2)} ",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.star, color: Colors.yellow.shade600),
                      // SizedBox(width: mq.width * .01),
                      Text(
                        "(1.8K Reviews)",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Rate the Product",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return rateProductDialog();
                            });
                      }),
                ],
              ),
              SizedBox(height: mq.height * .01),
              Divider(
                endIndent: mq.width * .01,
                indent: mq.width * .01,
                thickness: 2,
                color: Colors.grey[300],
              ),
              SizedBox(height: mq.height * .01),
              isProductAvailable
                  ? Text(
                      "Out of Stock",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  : const Text("In Stock",
                      style: TextStyle(color: Colors.teal)),
              // Container(height: 5, color: Colors.grey[200]),
              SizedBox(height: mq.height * .01),

              SizedBox(height: mq.width * .025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: isProductAvailable
                        ? () {
                            showSnackBar(
                                context: context, text: "Product out of stock");
                          }
                        : () {
                            showSnackBar(
                                context: context, text: "Added to cart");
                            addToCart();
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    child: Text(
                      "Add to Cart",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(letterSpacing: 1),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade500),
                    child: const Text("Buy Now",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),

              // TextButton(
              //     onPressed: () async {
              // ProductDetailServices productDetailServices =
              //     ProductDetailServices();

              // List<User>? userList = [];

              // userList = await productDetailServices.getUserImage(
              //     context: context, product: widget.product);

              // print("\n\nUserlist is :  ${userList}");
              // },
              // child: const Text("Get user image from rating")),

              SizedBox(height: mq.width * .03),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog rateProductDialog() {
    Size mq = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        "Drag your finger to rate",
        style: TextStyle(fontSize: 12, fontStyle: FontStyle.normal),
      ),
      content: RatingBar.builder(
        itemSize: 30,
        glow: true,
        glowColor: Colors.yellow.shade900,
        //rating given by user
        initialRating: double.parse(myRating.toString()),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemPadding: EdgeInsets.symmetric(horizontal: mq.width * .0125),
        itemCount: 5,
        itemBuilder: (context, _) {
          return const Icon(Icons.star, color: Colors.amber);
        },
        //changes here
        onRatingUpdate: (rating) {
          productDetailServices.rateProduct(
            context: context,
            product: widget.product,
            rating: rating,
          );
        },
      ),
      // contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Rate",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? Theme.of(context).primaryColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
