import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/home/widgets/address_box.dart';
import 'package:siento_shop/pages/search/widgets/searched_product.dart';
import 'package:siento_shop/pages/search/services/search_services.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:siento_shop/pages/product_details/screens/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({required this.searchQuery, super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  //fetching the searched product with the search query
  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: true,
          title: "All results for ${widget.searchQuery}",
          onClickSearchNavigateTo:
              MySearchScreen(searchQueryAlready: widget.searchQuery)),
      body: products == null
          ? SpinKitFadingCube(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            )
          : products!.isEmpty
              ? const Text("No product to display")
              : Column(
                  children: [
                    const AddressBox(),
                    SizedBox(height: mq.width * .025),
                    Expanded(
                      child: ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProductDetailScreen.routeName,
                                      arguments: products![index]);
                                },
                                child:
                                    SearchedProduct(product: products![index]));
                          }),
                    )
                  ],
                ),
    );
  }
}
