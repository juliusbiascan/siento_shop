import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/pages/cart/screens/cart_screen.dart';
import 'package:siento_shop/pages/home/screens/home_screen.dart';
import 'package:siento_shop/pages/account/screens/account_screen.dart';
import 'package:siento_shop/pages/category_grid/category_grid_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    CategoryGridScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  late Size mq;
  late TextTheme myTextTheme;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    myTextTheme = Theme.of(context).textTheme;

    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: pages[_page],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          child: BottomNavigationBar(
            currentIndex: _page,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0.0,
            onTap: updatePage,
            items: [
              //HOME PAGE
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: _page == 0
                      ? const Icon(Icons.home)
                      : const Icon(Icons.home_outlined),
                ),
                label: 'Home',
              ),
              // CATEGORIES
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: _page == 1
                      ? const Icon(Icons.grid_view_sharp)
                      : const Icon(Icons.grid_view_outlined),
                ),
                label: 'Categories',
              ),

              //CART
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: badges.Badge(
                    // displaying no of items in cart
                    badgeContent: Text("$userCartLen",
                        style: const TextStyle(color: Colors.white)),

                    badgeStyle: const badges.BadgeStyle(
                        badgeColor: Color.fromARGB(255, 19, 17, 17)),
                    child: _page == 2
                        ? const Icon(Icons.shopping_cart_rounded)
                        : const Icon(
                            Icons.shopping_cart_outlined,
                          ),
                  ),
                ),
                label: 'Cart',
              ),
              //ACCOUNT
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: _page == 3
                      ? const Icon(Icons.person_rounded)
                      : const Icon(Icons.person_outlined),
                ),
                label: 'Me',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
