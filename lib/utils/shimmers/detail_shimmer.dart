import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 200,
            height: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(width: 10),
              Container(
                width: 60,
                height: 20,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 150,
            height: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
