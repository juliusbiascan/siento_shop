import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final double? dividerEndIndent;
  const ScreenTitle({
    super.key,
    required this.title,
    this.dividerEndIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 18.sp,
                )),
        Divider(
          thickness: 3,
          endIndent: dividerEndIndent ?? 290,
        ),
      ],
    );
  }
}
