import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siento_shop/pages/home/widgets/carousel_image.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/home/services/home_services.dart';
import 'package:siento_shop/pages/home/screens/wish_list_screen.dart';
import 'package:siento_shop/pages/home/screens/category_deals_screen.dart';
import 'package:siento_shop/pages/product_details/screens/product_detail_screen.dart';
import 'package:siento_shop/pages/product_details/services/product_detail_services.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories>
    with TickerProviderStateMixin {
  // tabbar variables
  int activeTabIndex = 0;
  late final TabController _tabController;
  final int _tabLength = 5;

  // final ScrollController controller = ScrollController();

  //products
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  final ProductDetailServices productDetailServices = ProductDetailServices();
  //add to cart function copied, link it to the gridview items buttons

  bool favSelected = false;

  List<String> categoriesList = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
    fetchCategoryProducts(categoriesList[activeTabIndex]);
  }

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  void addToCart(String productName, Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  fetchCategoryProducts(String categoryName) async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: categoryName,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTabController(
          length: _tabLength,
          child: SizedBox(
            // color: Colors.cyan,
            height: mq.height * .07,
            // height: mq.height * .1,
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  activeTabIndex = index;
                });
                if (productList == null) {
                  fetchCategoryProducts(categoriesList[activeTabIndex]);
                }
              },
              labelPadding: const EdgeInsets.all(1),
              physics: const BouncingScrollPhysics(),
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              tabs: [
                for (int index = 0; index < _tabLength; index++)
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                GlobalVariables.categoryImages[index]['image']!,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).iconTheme.color!,
                                    BlendMode.srcIn)
                                // ignore: deprecated_member_use
                                ),
                            SizedBox(width: mq.width * .015),
                            Text(
                              GlobalVariables.categoryImages[index]['title']!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ]),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: mq.height * .02),
        const CarouselImage(),
        NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              _onTabChanged();
            }
            return false;
          },
          child: SizedBox(
            height: mq.height * 0.65,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //
                for (int i = 0; i < _tabLength; i++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: mq.height * .008)
                                .copyWith(right: mq.height * .015),
                        child: InkWell(
                          onTap: () {
                            navigateToCategoryPage(
                                context, categoriesList[activeTabIndex]);
                          },
                          child: Text("See More >",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      productList == null
                          ? SpinKitFadingCube(
                              color: Theme.of(context).colorScheme.primary,
                              size: 50.0,
                            )
                          : productList!.isEmpty
                              ? const Center(child: Text("No item to fetch"))
                              : GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.80,
                                  ),
                                  itemCount: min(productList!.length, 4),
                                  itemBuilder: (context, index) {
                                    Product product = productList![index];
                                    bool isProductAvailable =
                                        productList![index].quantity == 0;
                                    return Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        SizedBox(
                                          child: Card(
                                            elevation: 1,
                                            color: Theme.of(context).cardColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: mq.width * .025,
                                                  vertical: mq.width * .02),
                                              child: Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.stretch,
                                                children: [
                                                  // navigate to product details screen
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        ProductDetailScreen
                                                            .routeName,
                                                        arguments: product,
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      // color: Colors.redAccent,
                                                      // width: double.infinity,
                                                      height: mq.height * .15,
                                                      width: mq.width * .4,
                                                      child: Image.network(
                                                        // "https://rukminim1.flixcart.com/image/416/416/xif0q/computer/e/k/k/-original-imagg5jsxzthfd39.jpeg?q=70",
                                                        //iphone
                                                        // "https://rukminim1.flixcart.com/image/416/416/ktketu80/mobile/8/z/w/iphone-13-mlph3hn-a-apple-original-imag6vzzhrxgazsg.jpeg?q=70",
                                                        product.images[0],

                                                        //TV
                                                        // "https://rukminim1.flixcart.com/image/416/416/kiyw9e80-0/television/p/0/w/32path0011-thomson-original-imafynyvsmeuwtzr.jpeg?q=70",
                                                        // width: mq.width * .2,
                                                        // height: mq.height * .15,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: mq.height * .005),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      product.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    // color: Colors.blueAccent,
                                                    child: Text(
                                                      "PHP ${product.price.toStringAsFixed(2)}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton.icon(
                                                        style: TextButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade200),
                                                        onPressed: () {
                                                          homeServices
                                                              .addToWishList(
                                                                  context:
                                                                      context,
                                                                  product:
                                                                      product);
                                                          showSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Added to WishList",
                                                              onTapFunction:
                                                                  () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(GlobalVariables
                                                                        .createRoute(
                                                                            const WishListScreen()));
                                                              },
                                                              actionLabel:
                                                                  "View");
                                                        },
                                                        icon: const Icon(
                                                            CupertinoIcons.add,
                                                            size: 18,
                                                            color:
                                                                Colors.black87),
                                                        label: const Text(
                                                            "WishList",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87)),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                            onTap:
                                                                isProductAvailable
                                                                    ? () {
                                                                        showSnackBar(
                                                                            context:
                                                                                context,
                                                                            text:
                                                                                "Product out of stock");
                                                                      }
                                                                    : () {
                                                                        addToCart(
                                                                            product.name,
                                                                            product);
                                                                        showSnackBar(
                                                                            context:
                                                                                context,
                                                                            text:
                                                                                "Added to cart");
                                                                      },
                                                            child: const Icon(
                                                                CupertinoIcons
                                                                    .cart_badge_plus,
                                                                size: 35)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              // set to fav icon index
                                              // favSelected = index;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            padding: const EdgeInsets.all(3),
                                            // height: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle),
                                            child: Icon(Icons.favorite,
                                                color: favSelected
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 17),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onTabChanged() {
    switch (_tabController.index) {
      case 0:
        // handle 0 position
        activeTabIndex = 0;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;

      case 1:
        activeTabIndex = 1;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        // handle 1 position
        break;

      case 2:
        activeTabIndex = 2;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        // handle 1 position
        break;

      case 3:
        activeTabIndex = 3;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;

      case 4:
        activeTabIndex = 4;
        fetchCategoryProducts(categoriesList[activeTabIndex]);
        break;
    }
  }
}
