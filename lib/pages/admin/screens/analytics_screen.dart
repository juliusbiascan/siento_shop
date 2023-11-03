import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/account/services/account_services.dart';
import 'package:flutter/material.dart';

import 'package:siento_shop/main.dart';
import 'package:siento_shop/pages/admin/models/sales.dart';
import 'package:siento_shop/pages/admin/services/admin_services.dart';
import 'package:siento_shop/pages/admin/widgets/sales_graph/sales_graph.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  num? totalSales;
  List<Sales>? earnings;
  bool isLoading = false;
  // TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  @override
  void initState() {
    super.initState();
    isLoading = true;
    getEarnings();
    // _tooltipBehavior = TooltipBehavior(enable: true);
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<double> weeklySummary = [4.4, 5.05, 50.3, 99.9, 0, 78.98, 10.75];

  @override
  Widget build(BuildContext context) {
    // print("Earnings list<Sales> is \n\n${earnings![0].earning}");
    // return Center(child: ColorLoader3());
    return Scaffold(
      appBar: GlobalVariables.getAdminAppBar(
        title: "Analytics",
        context: context,
      ),
      body: isLoading
          ? Center(
              child: SpinKitFadingCube(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            ))
          : earnings == null || totalSales == null
              ?
              // no sales data available
              Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/no-orderss.png",
                        height: mq.height * .25,
                      ),
                      const Text(
                        "No sales data available",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              :

              // sales data available -> show bar chart
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Total sales achieved: PHP$totalSales",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w100)),
                      // SizedBox(
                      //     height: 300, child: MyBarGraph(weeklySummary: weeklySummary)),
                      const SizedBox(height: 80),
                      SizedBox(
                          height: 300,
                          child: SalesGraph(
                              salesSummary: earnings!
                                  .map((data) => data.earning)
                                  .toList())),

                      const SizedBox(height: 20),
                      for (int index = 0; index < 5; index++)
                        Text(
                          "${earnings![index].label} : PHP${earnings![index].earning}",
                          textAlign: TextAlign.left,
                        ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        icon: const Icon(Icons.logout_outlined),
        onPressed: () {
          AccountServices().logOut(context);
        },
        backgroundColor: Colors.deepPurple.shade600,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        label: const Text("LogOut", style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
