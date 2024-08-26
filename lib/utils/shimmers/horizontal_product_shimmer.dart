import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({super.key, required this.itemCount});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        itemCount: itemCount ,
          itemBuilder: (_,index){
        return Shimmer.fromColors(baseColor: Colors.red, highlightColor: Colors.yellow, child: Container(
         child: Column(
           children: [
             Container(
               height: 200,
               color: Colors.green,
             ),
             const SizedBox(height: 200,),
             Container(
               height: 200,
               color: Colors.blue,
             ),
           ],
         ),
        ));
      }),
    );
  }
}
