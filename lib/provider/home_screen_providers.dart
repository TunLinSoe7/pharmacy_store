import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/model/product_models_impl.dart';
import '../data/vos/product_vo.dart';

class HomeScreenProvider extends ChangeNotifier{
  bool _isDispose = false;
  final ProductModels _productModels = ProductModelImpl();

  List<ProductVO> promotionProducts = [];
  List<ProductVO> allProducts = [];

  HomeScreenProvider(){
    /// fetch promotion products
    _productModels.fetchPromotionProductListStream().listen((event) {
      print('promo=====================>${event?.length}');
      if(event!=null){
        promotionProducts = event;
        notifyListeners();
      }
    });

    /// fetch all products
    _productModels.fetchAllProductListStream().listen((event) {
      if(event!=null){
        allProducts = event;
        notifyListeners();
      }
    });
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