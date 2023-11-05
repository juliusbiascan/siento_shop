import 'package:flutter/material.dart';
import 'package:siento_shop/models/order.dart';
import 'package:siento_shop/components/widgets/bottom_bar.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/account/widgets/single_product.dart';
import 'package:siento_shop/pages/account/services/account_services.dart';
import 'package:siento_shop/pages/account/screens/all_orders_screen.dart';
import 'package:siento_shop/pages/order_details/screens/order_details_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

// status == 0 Pending
// status == 1 Completed
// status == 2 Received
// status == 3 Delivered
// status == 4 Product returned back

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  bool showLoader = false;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    setState(() {
      showLoader = true;
    });
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {
      showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: mq.width * 0.04),
              child: const Text("Your Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            InkWell(
              onTap: orders == null || orders!.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(context, AllOrdersScreen.routeName,
                          arguments: orders);
                    },
              child: Container(
                padding: EdgeInsets.only(right: mq.width * 0.04),
                child: Text(
                  "See all",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.selectedNavBarColor),
                ),
              ),
            ),
          ],
        ),
        showLoader
            ? SpinKitFadingCube(
                color: Theme.of(context).colorScheme.primary,
                size: 50.0,
              )
            : orders!.isEmpty
                ? Column(
                    children: [
                      Image.asset("assets/images/no-orderss.png",
                          height: mq.height * .15),
                      const Text("No Orders found"),
                      SizedBox(height: mq.height * 0.02),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, BottomBar.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.deepPurpleAccent),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Keep Exploring",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )),
                    ],
                  )
                : Container(
                    height: mq.height * .2,
                    padding: EdgeInsets.only(
                        left: mq.width * .025, top: mq.width * .05, right: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailsScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: SingleProduct(
                              image: orders![index].products[0].images[0]),
                        );
                      },
                    ),
                  )
      ],
    );
  }
}
