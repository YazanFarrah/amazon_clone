// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/api_paths.dart';
import '../../../constants/error_handling.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$getProducts?category=$category'), headers: {
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
