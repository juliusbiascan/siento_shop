// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:siento_shop/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/order_details/screens/order_details_screen.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:siento_shop/main.dart';
import 'package:siento_shop/models/order.dart';

class AllOrdersScreen extends StatefulWidget {
  static const String routeName = '/all-orders-screen';
  final List<Order>? allOrders;

  const AllOrdersScreen({
    Key? key,
    this.allOrders,
  }) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

// Fetching all orders logic
/*
          for (int i = 0; i < widget.allOrders!.length; i++)
            for (int j = 0; j < widget.allOrders![i].products.length; j++)
              Text(
                  "order id : ${widget.allOrders![i].orderedAt} ${widget.allOrders![i].products[j].name}\n",
                  style: TextStyle(fontSize: 15)),


*/

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          title: "All Orders",
          context: context,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.allOrders!.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(width: .2)),
            child: Column(
              children: [
                Container(
                  // color: Colors.deepOrange,
                  margin: EdgeInsets.only(
                      top: mq.height * .01, right: mq.height * .01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade800,
                            borderRadius: BorderRadius.circular(10)),

                        // elevation: 2,
                        // alignment: Alignment.topRight,
                        child: Text(
                          "Order ID : ${widget.allOrders![index].id}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                      SizedBox(width: mq.height * .01),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                    text: widget.allOrders![index].id))
                                .then((_) => showSnackBar(
                                    context: context, text: "Copied!"));
                          },
                          child: const Icon(Icons.copy, size: 17))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: widget.allOrders![index],
                    );
                    // Navigator.pushNamed(
                    //     context, ProductDetailScreen.routeName,
                    //     arguments: allOrders![index]);
                    Navigator.pushNamed(context, OrderDetailsScreen.routeName);
                  },
                  child: Column(
                    children: [
                      for (int j = 0;
                          j < widget.allOrders![index].products.length;
                          j++)
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: mq.width * .025),
                          child: Row(
                            children: [
                              // image
                              Image.network(
                                widget.allOrders![index].products[j].images[0],
                                // allOrders![index].products[index].images[0],
                                fit: BoxFit.contain,
                                height: mq.width * .25,
                                width: mq.width * .25,
                              ),
                              // description
                              Column(
                                children: [
                                  Container(
                                    width: mq.width * .57,
                                    padding: EdgeInsets.only(
                                        left: mq.width * .025,
                                        top: mq.width * .0125),
                                    child: Text(
                                      widget.allOrders![index].products[j].name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 16),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    width: mq.width * .57,
                                    padding: EdgeInsets.only(
                                        left: mq.width * .025,
                                        top: mq.width * .0125),
                                    child: Text(
                                        "Ordered At  : ${DateFormat('yMMMd').format(DateTime.fromMillisecondsSinceEpoch(widget.allOrders![index].orderedAt))}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq.height * .01,
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
