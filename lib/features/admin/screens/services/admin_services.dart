// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/api_paths.dart';
import '../../../../providers/products_provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dzu0odl3p', 'wpvakjqc');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(Uri.parse(adminAddProduct),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: product.toJson());
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          productProvider
              .addProduct(product); // Add the product to the provider
          showSnackBar(context, 'Product added successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all products

  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(Uri.parse(adminGetProducts), headers: {
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

  void deleteProduct({
    required BuildContext context,
    required Product product,
    //to show what to do in the posts screen
    required VoidCallback onSuccess,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.post(
        Uri.parse(adminDeleteProduct),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
