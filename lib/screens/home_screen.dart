import 'package:flutter/material.dart';
import 'package:pharmacy_store/provider/home_screen_providers.dart';
import 'package:pharmacy_store/screens/fou_you_all_screen.dart';
import 'package:pharmacy_store/screens/promotion_see_all_screen.dart';
import 'package:pharmacy_store/utils/constants/strings.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import '../utils/constants/colors.dart';
import 'package:provider/provider.dart';
import '../widgets/home_screen_widgets.dart';
import '../widgets/search_box_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>HomeScreenProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pharmacy Store'),
          actions: const [
            Icon(Icons.shopping_cart_outlined,color: kPrimaryColor,),
            SizedBox(width: 15,),
          ],
        ),
        body:  Column(
          children: [
            const SearchBoxWidget(),
            HorizontalTitleWidget(
              title: kPromotions,subtitle: 'See all',onTap: (){
              navigateToScreen(const PromotionSeeAllScreen(
                header: kPromotions,
              ), context);
            },),
            const PromotionProducts(),
            HorizontalTitleWidget(title: 'For You',subtitle: 'See all',onTap: (){
              navigateToScreen( const ForYouAllScreen(header: 'For You'), context);
            },),
            const AllProductWidget(),
          ],
        ),
      ),
    );
  }
}


