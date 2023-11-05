import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siento_shop/components/widgets/screen_title.dart';
import 'package:siento_shop/constants/constants.dart';

import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/account/widgets/below_app_bar.dart';
import 'package:siento_shop/pages/account/widgets/orders.dart';
import 'package:siento_shop/pages/account/widgets/settings_item.dart';
import 'package:siento_shop/pages/account/widgets/top_buttons.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Me",
          onClickSearchNavigateTo: const MySearchScreen()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
          children: [
            20.verticalSpace,
            Text('Account',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Mike Tyson',
              icon: Constants.userIcon,
              isAccount: true,
            ),
            SizedBox(height: mq.width * .025),
            const BelowAppBar(),
            SizedBox(height: mq.width * .025),
            const TopButtons(),
            SizedBox(height: mq.width * .045),
            const Orders(),
            30.verticalSpace,
            Text('Settings',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Language',
              icon: Constants.languageIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Sign Out',
              icon: Constants.logoutIcon,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
