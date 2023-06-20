import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              'Deal of the day',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Image.network(
            'https://images.unsplash.com/photo-1550029402-226115b7c579?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=765&q=80',
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            child: const Text(
              '\$999.0',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              'Yazan',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Image.network(
          //         'https://images.unsplash.com/photo-1539341029274-a659646db47c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
          //         fit: BoxFit.fitWidth,
          //         width: 100,
          //         height: 100,
          //       ),
          //       Image.network(
          //         'https://images.unsplash.com/photo-1539341029274-a659646db47c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
          //         fit: BoxFit.fitWidth,
          //         width: 100,
          //         height: 100,
          //       ),
          //       Image.network(
          //         'https://images.unsplash.com/photo-1539341029274-a659646db47c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
          //         fit: BoxFit.fitWidth,
          //         width: 100,
          //         height: 100,
          //       ),
          //       Image.network(
          //         'https://images.unsplash.com/photo-1539341029274-a659646db47c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
          //         fit: BoxFit.fitWidth,
          //         width: 100,
          //         height: 100,
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See all deals',
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
