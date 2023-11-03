import 'package:siento_shop/main.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;

    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as num)
        .toList();

    return Container(
      margin: EdgeInsets.all(mq.width * .025),
      child: Row(
        children: [
          const Text(
            "Subtotal ",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "PHP ${sum.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
