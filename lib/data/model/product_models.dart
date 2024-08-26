import 'package:pharmacy_store/data/vos/product_vo.dart';

import '../vos/cart_vo.dart';

abstract class ProductModels{
  Stream<List<ProductVO>?> fetchPromotionProductListStream();
  Stream<List<ProductVO>?> fetchAllProductListStream();
  Future<ProductVO> fetchProductById(String id);
  Future<void> addToCart(ProductVO product);
  Future<void> decreaseQuantity(CartVO cartVO);
  Future<void> increaseQuantity(CartVO cartVO);
  Stream<List<CartVO>?> fetchCartProductList();
}