import 'package:amazone_clone/common/custom_button.dart';
import 'package:amazone_clone/features/product_details/services/product_details_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/widgets/start.dart';
import '../../constants/global_variables.dart';
import '../../models/product.dart';
import '../search/screens/search_screen.dart';

class ProductScreenDetails extends StatefulWidget {
  static const String routeName = '/product-detals';
  final Product product;
  const ProductScreenDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductScreenDetails> createState() => _ProductScreenDetailsState();
}

class _ProductScreenDetailsState extends State<ProductScreenDetails> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.jo',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.id!,
                ),
                const RatingStars(
                  rating: 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          CarouselSlider(
            items: widget.product.images.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: 300,
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: 'Deal price: ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              text: 'Buy now',
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              color: Colors.teal,
              text: 'Add to cart',
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Rate this product',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: GlobalVariables.secondaryColor,
            ),
            onRatingUpdate: (rating) {
              productDetailsServices.addProductRating(
                context: context,
                product: widget.product,
                rating: rating,
              );
            },
          ),
        ],
      )),
    );
  }
}
