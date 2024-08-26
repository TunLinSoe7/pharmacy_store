import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/model/product_models_impl.dart';
import '../data/vos/product_vo.dart';

class ForYouAllScreenProvider extends ChangeNotifier{
  bool _isDispose = false;
  final ProductModels _productModels = ProductModelImpl();

  List<ProductVO> forYouAllProducts = [];

  ForYouAllScreenProvider(){
    /// fetch for you all products
    _productModels.fetchAllProductListStream().listen((event) {
      if(event!=null){
        forYouAllProducts = event;
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