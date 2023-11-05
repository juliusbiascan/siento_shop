import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:flutter/material.dart';

import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/home/widgets/deal_of_day.dart';
import 'package:siento_shop/pages/home/widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Home",
          dividerEndIndent: 260,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .04)
                    .copyWith(top: 10),
                child: const DealOfDay()),
            const TopCategories()
          ],
        ),
      ),
    );
  }
}
