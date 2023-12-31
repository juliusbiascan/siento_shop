import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:siento_shop/models/user.dart';
import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/constants/error_handling.dart';
import 'package:siento_shop/constants/global_variables.dart';

//

/*


    var jsondata = '{"id": "${product.id!}"}';

    var url = Uri.parse('$uri/api/add-to-cart');

 var response = await post(url, body: jsondata, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      print("response : ==> ${response.body}");


*/

//

class ProductDetailServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // var bodyData = {"id": "${product.id}"};
      http.Response res = await http.post(
        Uri.parse(
          '$uri/api/add-to-cart',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!}),
      );

      // http.Response res = await http.post(
      //   Uri.parse("$uri/api/add-to-cart"),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'x-auth-token': userProvider.user.token,
      //   },
      //   body: jsonEncode({'id': product.id!}),
      // );

      // print("\nPost request sent successfully...");

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      if (context.mounted) showSnackBar(context: context, text: e.toString());
    }
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  // Future<List<User>?> getUserImage(
  //     {required BuildContext context, required Product product}) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<User>? userList = [];

  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse("$uri/api/get-user-of-product"),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );

  //     var data = jsonDecode(res.body);
  //     print("\nData coming -------------------------- $data");

  //     //use context ensuring the mounted property across async functions
  //     if (context.mounted) {
  //       httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           // for (Map<String, dynamic> item in data) {
  //           //   userList.add(User.fromJson(jsonEncode((item))));
  //           // }
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     showSnackBar(context: context, text: e.toString());
  //   }
  //   return userList;
  // }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      //use context ensuring the mounted property across async functions
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      if (context.mounted) showSnackBar(context: context, text: e.toString());
    }
  }
}
