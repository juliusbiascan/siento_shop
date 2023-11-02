import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:siento_shop/main.dart';
import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/features/home/services/home_services.dart';
import 'package:siento_shop/features/product_details/screens/product_detail_screen.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? SpinKitWave(
            color: Theme.of(context).colorScheme.primary,
            size: 50.0,
          )
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.cyanAccent,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: mq.width * .03),
                      child: const Text("Deal of the day",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image.network(
                          // "https://github.com/AKR-2803/ShoesAppUIFlutter/blob/main/assets/images/shoes_display.png?raw=true",
                          product!.images[0],
                          fit: BoxFit.fitHeight,
                        ),
                        Image.asset("assets/images/dealOfTheDaypng.png",
                            height: mq.height * 0.075),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, right: 40, top: 5),
                      child: Text("PHP ${product!.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, right: 40, top: 5),
                      child: const Text(
                        "Save big on the best",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fitWidth,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
  }
}
