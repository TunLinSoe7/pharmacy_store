import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/promotion_see_all_screen_provider.dart';
import 'package:pharmacy_store/utils/constants/colors.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import 'package:provider/provider.dart';

class PromotionSeeAllScreen extends StatelessWidget {
  const PromotionSeeAllScreen({super.key, required this.header});
  final String header;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>PromotionAllScreenProvider(),
      child: Consumer<PromotionAllScreenProvider>(
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
                      InkWell(
                        onTap: (){
                          provider.sortProductAZ();
                        },
                        child: Text('Sort',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kGreyColor
                        ),),
                      ),
                      const Spacer(),
                      InkWell(
                         onTap: (){
                           provider.filterProductsByPrice(0,1000);
                         },
                          child: const Icon(Icons.filter_list,size: 30,color: kGreyColor,)),
                      Text('Filter',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kGreyColor
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(child: ListView.builder(
                  itemCount: provider.promotionProducts.length,
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
                                CachedNetworkImage(imageUrl: '${provider.promotionProducts[index].image}',width: 100,height: 100,fit: BoxFit.fill,),
                                 const SizedBox(width: 10,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('${provider.promotionProducts[index].title}', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                         color: kTitleColor,
                                     )),
                                     const SizedBox(height: 5,),
                                     Text('${provider.promotionProducts[index].price} MMK',style: const TextStyle(
                                       decoration: TextDecoration.lineThrough,
                                       color: Colors.red
                                     ),),
                                     const SizedBox(height: 5,),
                                     Text('${calculateDiscountedPrice(provider.promotionProducts[index].price ?? 0, provider.promotionProducts[index].discountPercent ?? 0)} MMK',
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
