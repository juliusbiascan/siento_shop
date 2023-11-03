import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/features/home/widgets/address_box.dart';

import 'package:siento_shop/main.dart';
import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/features/home/services/home_services.dart';
import 'package:siento_shop/features/home/screens/filters_screen.dart';
import 'package:siento_shop/features/home/providers/filter_provider.dart';
import 'package:siento_shop/features/search/widgets/searched_product.dart';
import 'package:siento_shop/features/search_delegate/my_search_screen.dart';
import 'package:siento_shop/features/product_details/screens/product_detail_screen.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  bool light1 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  final MaterialStateProperty<Color?> thumbColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return const Color.fromARGB(255, 77, 24, 24);
    },
  );

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: true,
          title: "All results in ${widget.category}",
          onClickSearchNavigateTo: const MySearchScreen()),
      body: productList == null
          ? SpinKitFadingCube(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(height: 30, "assets/images/app_iconv2.png"),
                        const Text("Siento Deals"),
                        SizedBox(
                          height: 30,
                          width: 50,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Switch(
                              activeColor: Colors.blue,
                              thumbColor: thumbColor,
                              thumbIcon: thumbIcon,
                              value: light1,
                              onChanged: (bool value) {
                                setState(() {
                                  light1 = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            GlobalVariables.createRoute(const FilterScreen()));
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Divider(
                              height: 10, thickness: 20, color: Colors.grey),
                          Text("Filters(1)"),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: mq.height * .001),
                const AddressBox(),
                SizedBox(height: mq.width * .025),
                filterProvider.filterNumber == 1
                    ? getFilterNameList(filterProvider)
                    : filterProvider.filterNumber == 2
                        ? getFilterpriceLtoH(filterProvider)
                        : filterProvider.filterNumber == 3
                            ? getFilterpriceHtoL(filterProvider)
                            : Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: productList!.length,
                                  itemBuilder: (context, index) {
                                    var map = productList!;
                                    if (kDebugMode) {
                                      print(
                                          "Type of productlist.....................${map[index]}");
                                    }

                                    // productList!
                                    //     .sort((a, b) => a.brandName.contains("d"));

                                    if (kDebugMode) {
                                      print(
                                          "product list now..............${productList![index].name}, ");
                                    }
                                    // var sortedByKeyMap = Map.fromEntries(map.entries.toList()
                                    //   ..sort((e1, e2) => e1.key.compareTo(e2.key)));
                                    return Column(
                                      children: [
                                        // Text(
                                        //     "Filter  : ${filterProvider.getFilterNumber}"),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  ProductDetailScreen.routeName,
                                                  arguments:
                                                      productList![index]);
                                            },
                                            child: SearchedProduct(
                                                product: productList![index])),
                                        // Divider(
                                        //     color: Colors.grey, thickness: mq.height * .001)
                                      ],
                                    );
                                  },
                                ),
                              ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep shopping for ${widget.category}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: productList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                        ),
                        itemBuilder: (context, index) {
                          Product product = productList![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailScreen.routeName,
                                arguments: product,
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.network(
                                        product.images[0],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    top: 5,
                                    right: 15,
                                  ),
                                  child: Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  getFilterNameList(FilterProvider filterProvider) {
    List<Product>? filterOneList = productList;
    filterOneList!.sort((a, b) => a.brandName.compareTo(b.brandName));

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: filterOneList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text("Filter  : ${filterProvider.getFilterNumber}"),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                        arguments: filterOneList[index]);
                  },
                  child: SearchedProduct(product: filterOneList[index])),
              Divider(color: Colors.grey, thickness: mq.height * .001)
            ],
          );
        },
      ),
    );
  }

  getFilterpriceLtoH(FilterProvider filterProvider) {
    List<Product>? filterOneList = productList;
    filterOneList!.sort((a, b) => a.price.compareTo(b.price));

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: filterOneList.length,
        itemBuilder: (context, index) {
          // print(
          //     "Type of productlist.....................${map[index].}");

          // productList!
          //     .sort((a, b) => a.brandName.contains("d"));

          // var sortedByKeyMap = Map.fromEntries(map.entries.toList()
          //   ..sort((e1, e2) => e1.key.compareTo(e2.key)));
          return Column(
            children: [
              Text("Filter  : ${filterProvider.getFilterNumber}"),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                        arguments: filterOneList[index]);
                  },
                  child: SearchedProduct(product: filterOneList[index])),
              // Divider(
              //     color: Colors.grey, thickness: mq.height * .001)
            ],
          );
        },
      ),
    );
  }

  getFilterpriceHtoL(FilterProvider filterProvider) {
    List<Product>? filterOneList = productList;
    filterOneList!.sort((a, b) => a.price.compareTo(b.price));

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: filterOneList.length,
        itemBuilder: (context, index) {
          // print(
          //     "Type of productlist.....................${map[index].}");

          // productList!
          //     .sort((a, b) => a.brandName.contains("d"));

          // var sortedByKeyMap = Map.fromEntries(map.entries.toList()
          //   ..sort((e1, e2) => e1.key.compareTo(e2.key)));
          return Column(
            children: [
              // Text("Filter  : ${filterProvider.getFilterNumber}"),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                        arguments: filterOneList[index]);
                  },
                  child: SearchedProduct(
                      product: filterOneList.reversed.toList()[index])),
              // Divider(
              //     color: Colors.grey, thickness: mq.height * .001)
            ],
          );
        },
      ),
    );
  }
}
