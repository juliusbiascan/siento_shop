import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siento_shop/constants/constants.dart';

class NoData extends StatelessWidget {
  final String? text;
  const NoData({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Column(
      children: [
        80.verticalSpace,
        Image.asset(
          Constants.noData,
          width: mq.width * .4,
          height: mq.height * .2,
        ),
        20.verticalSpace,
        Text(text ?? 'No Data',
            style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
