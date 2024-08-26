import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pharmacy_store/provider/whist_list_provider.dart';
import 'package:pharmacy_store/screens/product_detail_screen.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import 'package:pharmacy_store/utils/shimmers/horizontal_product_shimmer.dart';
import 'package:provider/provider.dart';
import '../data/vos/product_vo.dart';
import '../provider/home_screen_providers.dart';
import '../utils/constants/colors.dart';

class AllProductWidget extends StatelessWidget{
  const AllProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeScreenProvider,List<ProductVO>?>(builder: (_,allProducts,__){
      final favProvider = context.watch<WhistListProvider>();
      return SizedBox(height: 240,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allProducts?.length,
            itemBuilder: (_,index){
              bool isInWishlist = favProvider.whistList.any(
                    (product) => product.productId == allProducts?[index].productId,
              );
              return PromotionCardItemView(
                onTapFav: ()async{
                  bool isWhistList = await favProvider.isWhistList(allProducts?[index].productId ?? '');
                  isWhistList?favProvider.removeFromWhistList(allProducts?[index].productId ?? ''):favProvider.addToWhistList(allProducts?[index] ?? ProductVO());
                },
                isWhistList: isInWishlist,
                onTap: (){
                  navigateToScreen( ProductDetailScreen(productId: '${allProducts?[index].productId}'), context);
                },
                title: '${allProducts?[index].title}',
                image: '${allProducts?[index].image}',
                percentage: '${allProducts?[index].discountPercent} %',
                price: '${allProducts?[index].price} MMK', isDiscount: false,
              );
            }),);
    }, selector: (_,provider)=>provider.allProducts);
  }
}
class PromotionProducts extends StatelessWidget{
  const PromotionProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<WhistListProvider>();
    return Selector<HomeScreenProvider,List<ProductVO>?>(builder: (_,promotionProducts,__){
      if(promotionProducts == null || promotionProducts.isEmpty){
        return HorizontalProductShimmer(itemCount: promotionProducts?.length ?? 10);
      }else{
        return SizedBox(height: 225,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: promotionProducts.length,
              itemBuilder: (_,index){
                bool isInWishlist = favProvider.whistList.any(
                      (product) => product.productId == promotionProducts[index].productId,
                );
                return PromotionCardItemView(
                  isWhistList: isInWishlist,
                  onTapFav: ()async{
                    bool isWhistList = await favProvider.isWhistList(promotionProducts[index].productId ?? '');
                    isWhistList?favProvider.removeFromWhistList(promotionProducts[index].productId ?? ''):favProvider.addToWhistList(promotionProducts[index]);
                  },
                  onTap: (){
                    navigateToScreen(ProductDetailScreen(productId: '${promotionProducts[index].productId}',), context);
                  },
                  discountPrice: '${promotionProducts[index].price} MMK',
                  title: '${promotionProducts[index].title}',
                  image: '${promotionProducts[index].image}',
                  percentage: '${promotionProducts[index].discountPercent} %',
                  price: '${calculateDiscountedPrice(
                    promotionProducts[index].price ?? 0,
                    promotionProducts[index].discountPercent ?? 0,
                  )} MMK', isDiscount: true,
                );
              }),);
      }
    }, selector: (_,provider)=>provider.promotionProducts);
  }
}

class PromotionCardItemView extends StatelessWidget {
  const PromotionCardItemView({
    super.key,
    required this.title,
    required this.image,
    required this.percentage,
    required this.price, required this.isDiscount, this.discountPrice, this.onTap, this.onTapFav, required this.isWhistList,
  });
  final String title;
  final String image;
  final String percentage;
  final String price;
  final String? discountPrice;
  final bool isDiscount;
  final bool isWhistList;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapFav;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            shadowColor: Colors.black,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 225,
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: GestureDetector(
                      onTap: onTap,
                      child: CachedNetworkImage(
                        imageUrl: image,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kTitleColor,
                    ),
                  ),
                  Visibility(
                    visible: isDiscount,
                    child: Text(
                      discountPrice ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
               onTap: onTapFav,
                child: CircleAvatar(child: Icon(Iconsax.heart,color: isWhistList?Colors.red:Colors.black,))),
          ),
          Visibility(
            visible: isDiscount,
            child: Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kRedColor,
                ),
                child: Text(
                  percentage,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalTitleWidget extends StatelessWidget {
  const HorizontalTitleWidget({
    super.key, required this.title, required this.subtitle, required this.onTap,
  });
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: kTitleColor,
          fontWeight: FontWeight.normal
      ),),

      trailing: InkWell(
        onTap: onTap,
        child: Text(subtitle,style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.normal
        ),),
      ),
    );
  }
}
