import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/for_you_screen_provider.dart';
import 'package:pharmacy_store/utils/constants/colors.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';

class ForYouAllScreen extends StatelessWidget {
  const ForYouAllScreen({super.key, required this.header});
  final String header;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>ForYouAllScreenProvider(),
      child: Consumer<ForYouAllScreenProvider>(
        builder: (_,provider,__){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: Text(header),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(Icons.sort,size: 30,color: kGreyColor,),
                      Text('Sort',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kGreyColor
                      ),),
                      const Spacer(),
                      const Icon(Icons.filter_list,size: 30,color: kGreyColor,),
                      Text('Filter',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kGreyColor
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(child: ListView.builder(
                    itemCount: provider.forYouAllProducts.length,
                    itemBuilder: (_,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(imageUrl: '${provider.forYouAllProducts[index].image}',width: 100,height: 100,fit: BoxFit.fill,),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${provider.forYouAllProducts[index].title}', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                          color: kTitleColor,
                                        )),
                                        const SizedBox(height: 5,),
                                        Text('${calculateDiscountedPrice(provider.forYouAllProducts[index].price ?? 0, provider.forYouAllProducts[index].discountPercent ?? 0)} MMK',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                color: kPrimaryColor
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Positioned(
                                top: 15,
                                right: 15,
                                child: Icon(Icons.favorite_outline_outlined,color: kPrimaryColor,size: 30,))
                          ],
                        ),
                      );
                    }))
              ],
            ),
          );
        },
      ),
    );
  }
}
