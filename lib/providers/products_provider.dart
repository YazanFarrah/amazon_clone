import 'package:amazone_clone/models/product.dart';
import 'package:amazone_clone/features/admin/screens/services/admin_services.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final AdminServices adminServices = AdminServices();
  List<Product>? _products;

  List<Product>? get products => _products;

  Future<void> fetchAllProducts(BuildContext context) async {
    _products = await adminServices.fetchAllProducts(context: context);
    notifyListeners();
  }

  void addProduct(Product product) {
    _products?.add(product);
    notifyListeners();
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required int index}) {
    adminServices.deleteProduct(
        context: context, product: product, onSuccess: () {});
    _products?.removeAt(index);
    notifyListeners();
  }
}
