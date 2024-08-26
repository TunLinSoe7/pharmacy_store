import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/model/product_models_impl.dart';
import '../data/vos/product_vo.dart';

class ProductDetailScreenProvider extends ChangeNotifier{
  bool _isDispose = false;
  final ProductModels _productModels = ProductModelImpl();

  ProductVO? productVO;

  ProductDetailScreenProvider(String id){
    /// fetch detail products
    _productModels.fetchProductById(id).then((value) {
      print('value================>$value');
      productVO = value;
      notifyListeners();
    });
  }

  Future<void> addToCart(ProductVO product)async{
    try{
      await _productModels.addToCart(product);
      notifyListeners();
    }catch (e){
      print('add to cart failed=============>$e');
    }
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