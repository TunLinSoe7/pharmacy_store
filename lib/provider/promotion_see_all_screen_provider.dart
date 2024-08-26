import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/model/product_models_impl.dart';
import '../data/vos/product_vo.dart';
import '../utils/helper_functions/helper_functions.dart';

class PromotionAllScreenProvider extends ChangeNotifier{
  bool _isDispose = false;
  final ProductModels _productModels = ProductModelImpl();

  List<ProductVO> promotionProducts = [];

  PromotionAllScreenProvider(){
    /// fetch promotion products
    _productModels.fetchPromotionProductListStream().listen((event) {
      print('all=====================>${event?.length}');
      if(event!=null){
        promotionProducts = event;
        notifyListeners();
      }
    });
  }

  void sortProductAZ(){
    promotionProducts.sort((a,b)=>a.title!.compareTo(b.title ?? ''));
    notifyListeners();
  }

  void filterProductsByPrice(double minPrice, double maxPrice) {
    promotionProducts = promotionProducts.where((product) {
      final price = calculateDiscountedPrice(product.price ?? 0, product.discountPercent ?? 0);
      return price >= minPrice && price <= maxPrice;
    }).toList();
    notifyListeners();
  }



  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!_isDispose){
      super.notifyListeners();
    }
  }
}