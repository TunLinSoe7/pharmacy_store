import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/add_to_cart_provider.dart';
import 'package:provider/provider.dart';
import '../utils/constants/colors.dart';
import '../widgets/home_screen_widgets.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>AddToCartProvider(),
      child: Consumer<AddToCartProvider>(
        builder: (_,provider,__){
          return Scaffold(
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black)
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15) ),
                ),
                height: 250,
                child: const CheckOutWidget(),
              ),
              appBar: AppBar(
                title: const Text('Shopping Cart'),
              ),
              body:  ListView.builder(
                itemCount:provider.cartList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Colors.white,
                          child: Container(
                            height: 110,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color:Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: 100,
                                    height: 110,
                                    child: CachedNetworkImage(imageUrl: '${provider.cartList[index].productImage}',width: 100,height: 120,)),
                                const SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text('${provider.cartList[index].productTitle}',style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14
                                      ),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 23,
                          right: 25,
                          child: InkWell(
                              onTap: (){
                              },
                              child:Image.asset('assets/images/delete1.png',width: 20,height: 20,))),
                      Positioned(
                          bottom: 23,
                          right: 25,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.1),
                                    width: 2
                                )
                            ),
                            child:Row(
                              children: [
                                InkWell(
                                    onTap: (){
                                      provider.decreaseQuantity(provider.cartList[index]);
                                    },
                                    child:CircleAvatar(
                                      backgroundColor: Colors.blue.withOpacity(0.1),
                                       radius: 15,
                                        child: const Icon(Icons.remove,))),
                                const SizedBox(width: 10,),
                                Text('${provider.cartList[index].productQuantity}',style: const TextStyle(
                                    color: kPrimaryColor
                                ),),
                                const SizedBox(width: 10,),
                                InkWell(
                                    onTap: (){
                                      provider.increaseQuantity(provider.cartList[index]);
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Colors.blue.withOpacity(0.1),
                                        radius: 15,
                                        child: const Icon(Icons.add))),
                              ],
                            ) ,
                          )),
                    ],
                  );
                },
              )
          );
        },
      ),
    );
  }
}

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddToCartProvider>();
    return ListView(
      children: [
        HorizontalTitleWidget(
          title: 'Product Price',
          subtitle: '', onTap: () {  },
        ), HorizontalTitleWidget(
          title: 'Tax Fees',
          subtitle: 'No Fee', onTap: () {  },
        ),HorizontalTitleWidget(
          title: 'SubTotal',
          subtitle: '${provider.getTotalPrice()} MMK', onTap: () {  },
        ),

        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30)
          ),
          child: const Text('Proceed to checkout',style:TextStyle(
              color: Colors.white,
              fontSize: 16
          ),),
        ),
      ],
    );
  }
}
