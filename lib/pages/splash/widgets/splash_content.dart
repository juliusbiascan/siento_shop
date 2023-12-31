import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_iconv2.png",
              height: 40,
              // height: mq.height * .04,
            ),
            SizedBox(width: mq.width * .03),
            Text(
              "SIENTO",
              style: TextStyle(
                fontSize: 50,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(flex: 2),
        Image.asset(
          image!,
          height: 100,
          width: 100,
        ),
      ],
    );
  }
}
