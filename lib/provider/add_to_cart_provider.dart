import 'package:flutter/material.dart';
import '../data/model/product_models.dart';
import '../data/model/product_models_impl.dart';
import '../data/vos/cart_vo.dart';

class AddToCartProvider extends ChangeNotifier{
  final ProductModels  _productModel = ProductModelImpl();
  List<CartVO> cartList = [];
 AddToCartProvider(){
   _productModel.fetchCartProductList().listen((event) {
     cartList = event ?? [];
     notifyListeners();
   });
 }

  /// total price
  int getTotalPrice() {
    int totalPrice = 0;
    for (var item in cartList) {
      totalPrice += item.totalPrice ?? 0;
    }
    return totalPrice;
  }

  /// increase product count
  Future<void> increaseQuantity(CartVO cartVO)async{
    await _productModel.increaseQuantity(cartVO);
    notifyListeners();
  }
  /// decrease product count
  Future<void> decreaseQuantity(CartVO cartVO)async{
    await _productModel.decreaseQuantity(cartVO);
    notifyListeners();
  }

}