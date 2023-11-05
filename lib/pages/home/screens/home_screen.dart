import 'package:siento_shop/pages/home/widgets/address_box.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:flutter/material.dart';

import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/home/widgets/deal_of_day.dart';
import 'package:siento_shop/pages/home/services/home_services.dart';
import 'package:siento_shop/pages/home/widgets/top_categories.dart';
import 'package:siento_shop/pages/search/screens/search_screen.dart';

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => MySearchScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.decelerate;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(position: animation.drive(tween), child: child);
//     },
//   );
// }

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchOn = false;
  TextEditingController searchController = TextEditingController();

  final historyLength = 5;

  List<String> filteredSearchHistory = [];

  String? selectedTerm;

  HomeServices homeServices = HomeServices();
  List<String>? searchHistoryList = [];
  List<String>? productNames = [];

  List<String>? searchSuggestionsList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool onChangeActive = false;

  fetchAllProductsNames() async {
    productNames = await homeServices.fetchAllProductsNames(context);
    setState(() {});
  }

  fetchSearchHistory() async {
    searchHistoryList = await homeServices.fetchSearchHistory(context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    //make sure to pass the arguments here!
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    // final searchProvider = Provider.of<SearchProvider>(context);
    // _searchHistory = searchProvider.getSearchlist;

    // print("\n\n==========> Product Names are : $productNames");
    // print("\n\n==========> _searchHistoryList : $searchHistoryList");

    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: GlobalVariables.getAppBar(
            context: context,
            wantBackNavigation: false,
            title: "Home",
            dividerEndIndent: 260,
            onClickSearchNavigateTo: const MySearchScreen()),
        //functionalities!
        body: const SingleChildScrollView(
          child: Column(
            children: [AddressBox(), DealOfDay(), TopCategories()],
          ),
        ),
      ),
    );
  }
}
