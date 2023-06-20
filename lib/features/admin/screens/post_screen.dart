import 'package:amazone_clone/common/widgets/single_product.dart';
import 'package:amazone_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
import '../../../providers/products_provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchAllProducts(context);
  }

  void deleteProduct(Product product, int index) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.deleteProduct(
        context: context, index: index, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return products == null
        ? const Loader()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a product',
              onPressed: navigateToAddProduct,
              child: const Icon(Icons.add),
            ),
            body: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteProduct(productData, index);
                          },
                          icon: const Icon(Icons.delete_outline),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          );
  }
}
