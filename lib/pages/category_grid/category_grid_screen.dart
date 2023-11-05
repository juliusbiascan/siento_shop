import 'package:flutter/material.dart';

import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:siento_shop/pages/home/screens/category_deals_screen.dart';

class CategoryGridScreen extends StatefulWidget {
  const CategoryGridScreen({super.key});

  @override
  State<CategoryGridScreen> createState() => _CategoryGridScreenState();
}

class _CategoryGridScreenState extends State<CategoryGridScreen> {
  final List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Categories",
          dividerEndIndent: 215,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(mq.height * .01),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.4,
            crossAxisSpacing: mq.width * .03,
            mainAxisSpacing: mq.width * .015,
            crossAxisCount: 2),
        itemCount: productCategories.length,
        itemBuilder: (context, index) {
          // print("\n\nimage path is : ${myCategoryList[index]['title']}");
          final categoryTitle = productCategories[index];

          return InkWell(
            onTap: () {
              navigateToCategoryPage(context, productCategories[index]);
            },
            child: Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    categoryTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
