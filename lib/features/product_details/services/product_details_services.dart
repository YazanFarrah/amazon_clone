// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_paths.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import 'package:http/http.dart' as http;

import '../../../providers/user_provider.dart';

class ProductDetailsServices {
  void addProductRating({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse(rateProduct),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id,
            'rating': rating,
          }));
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
