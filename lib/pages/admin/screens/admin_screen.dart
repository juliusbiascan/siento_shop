import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:siento_shop/pages/admin/screens/posts_screen.dart';
import 'package:siento_shop/pages/admin/screens/orders_screen.dart';
import 'package:siento_shop/pages/admin/screens/analytics_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "Type of user ==========> ${Provider.of<UserProvider>(context).user.type}");
    return Scaffold(
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
              //POSTS
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: bottomBarWidth,
                  child: const Icon(Icons.home_outlined),
                ),
                label: '',
              ),
              //ANALYTICS
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: bottomBarWidth,
                  child: const Icon(Icons.analytics_outlined),
                ),
                label: '',
              ),
              //ORDERS
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: bottomBarWidth,
                  child: const Icon(Icons.all_inbox_outlined),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
