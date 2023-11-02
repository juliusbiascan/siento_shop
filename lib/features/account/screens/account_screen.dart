import 'package:flutter/material.dart';

import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/features/account/widgets/below_app_bar.dart';
import 'package:siento_shop/features/account/widgets/orders.dart';
import 'package:siento_shop/features/account/widgets/top_buttons.dart';
import 'package:siento_shop/features/search_delegate/my_search_screen.dart';
import 'package:siento_shop/main.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Me",
          onClickSearchNavigateTo: MySearchScreen()),
      body: Column(
        children: [
          SizedBox(height: mq.width * .025),
          const BelowAppBar(),
          SizedBox(height: mq.width * .025),
          TopButtons(),
          SizedBox(height: mq.width * .045),
          const Orders(),
        ],
      ),
    );
  }
}
