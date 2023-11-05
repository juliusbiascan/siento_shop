import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siento_shop/constants/constants.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title,
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: 16.sp,
          )),
      subtitle: !isAccount
          ? null
          : Text(
              '+218 92 00 000 00',
              style: theme.textTheme.displaySmall,
            ),
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 25.r,
        backgroundColor: theme.primaryColor,
        child: SvgPicture.asset(icon, fit: BoxFit.none),
      ),
      trailing: isDark
          ? CupertinoSwitch(
              value: true,
              activeColor: theme.primaryColor,
              onChanged: (bool value) {},
            )
          : Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SvgPicture.asset(Constants.forwardArrowIcon,
                  fit: BoxFit.none),
            ),
    );
  }
}
