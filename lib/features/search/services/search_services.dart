import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:siento_shop/models/product.dart';
import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/constants/error_handling.dart';
import 'package:siento_shop/constants/global_variables.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      var data = jsonDecode(res.body);

      // List listLength = jsonDecode(res.body);
      //jsonEncode => [object] to a JSON string.
      //jsonDecode => String to JSON object.
      if (context.mounted) {
        httpErrorHandle(
          //handling the http errors quiet efficiently
          response: res,
          context: context,
          onSuccess: () {
            for (Map<String, dynamic> item in data) {
              // print(item['name']);
              productList.add(Product.fromJson(item));
            }
          },
        );
      }

      // print("Products length : ${jsonDecode(res.body).length}");
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
            context: context,
            text:
                "Following Error in fetching Products [Search] : ${e.toString()}");
      }
    }
    return productList;
  }
}
