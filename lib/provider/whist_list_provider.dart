import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/model/product_models_impl.dart';

import '../data/vos/product_vo.dart';

class WhistListProvider extends ChangeNotifier{
  final ProductModels _productModels = ProductModelImpl();
  List<ProductVO> whistList = [];
  WhistListProvider(){
    _productModels.fetchWhistList().listen((event) {
      whistList = event ?? [];
      notifyListeners();
    });
  }

  Future<void> addToWhistList(ProductVO productVO)async{
    await _productModels.addToWhistList(productVO);
    notifyListeners();
  }
  Future<void> removeFromWhistList(String productId)async{
    await _productModels.removeFromWhistList(productId);
    notifyListeners();
  }

  Future<bool> isWhistList(String productId){
    return _productModels.isFavourite(productId);
  }
}