// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_paths.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$searchProducts/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userToken,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                //because fromJson accepts a String and jsonEncode is of type String, but jsonDecode is of type dynamic
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
