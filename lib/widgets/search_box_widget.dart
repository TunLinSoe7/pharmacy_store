import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.15)
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded,color: Colors.grey,),
          const SizedBox(width: 15,),
          Text('Search Drugs',style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey
          ),)
        ],
      ),
    );
  }
}