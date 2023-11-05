import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .0125),
        child: Card(
          color: Theme.of(context).cardColor,
          child: Container(
            width: mq.width * .45,
            padding: EdgeInsets.all(mq.width * .025),
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
