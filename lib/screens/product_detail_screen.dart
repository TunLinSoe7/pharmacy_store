import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pharmacy_store/provider/product_detail_provider.dart';
import 'package:pharmacy_store/screens/cart_screen.dart';
import 'package:pharmacy_store/utils/constants/colors.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import 'package:pharmacy_store/utils/shimmers/detail_shimmer.dart';
import 'package:provider/provider.dart';
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ProductDetailScreenProvider(productId),
      child: Consumer<ProductDetailScreenProvider>(
        builder: (_,provider,__)=>SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: const [
                Icon(Iconsax.notification),
                SizedBox(width: 15,),
                Icon(Iconsax.shopping_bag),
                SizedBox(width: 15,),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: provider.productVO==null?const ProductDetailShimmer():Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: CachedNetworkImage(imageUrl: '${provider.productVO?.image}')),
                  const SizedBox(height: 15,),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text('${provider.productVO?.title}',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black
                              ),maxLines: 2,)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              provider.productVO?.discountPercent != 0?Text('${provider.productVO?.price} MMK',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  decoration: TextDecoration.lineThrough
                              ),):const SizedBox(),
                              const SizedBox(width: 10,),
                              Text('${calculateDiscountedPrice(provider.productVO?.price ?? 0, provider.productVO?.discountPercent ?? 0)} MMK',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Colors.black
                              ),),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          provider.addToCart(provider.productVO!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kPrimaryColor,
                                    width: 1.5
                                  )
                                ),
                                child: const Icon(Iconsax.add,color: kPrimaryColor,size: 18,),
                              ),
                              const SizedBox(width: 10,),
                              Text('Add To Cart',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: kPrimaryColor
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black,thickness: 0.3,),
                  Text('Package Size',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black
                  ),),
                  const SizedBox(height: 15,),
                  SizedBox(height:40,child: ListView.separated(
                    separatorBuilder: (_,index)=>const SizedBox(width: 15,),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                      itemBuilder: (_,index){
                    return Container(
                      alignment: Alignment.center,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: kPrimaryColor)
                      ),
                      child: const Text('500 mg'),
                    );
                  }),),
                  const SizedBox(height: 15,),
                  Text('Product Details',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black
                  ),),
                  Text('${provider.productVO?.description}',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey
                  ),textAlign: TextAlign.justify,),
                ],
              ),
            ),
            bottomNavigationBar: GestureDetector(
              onTap: (){
                navigateToScreen(const CartView(), context);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kPrimaryColor
                ),
                height: 50,
                child: Text('GO TO CART',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
