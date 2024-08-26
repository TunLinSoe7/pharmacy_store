import 'package:pharmacy_store/data/vos/cart_vo.dart';
import 'package:pharmacy_store/data/vos/product_vo.dart';

abstract class ProductDataAgent{
  Stream<List<ProductVO>?> fetchPromotionProductListStream();
  Stream<List<ProductVO>?> fetchAllProductListStream();
  Future<ProductVO> fetchProductById(String id);
  Future<void> addProductToCart(ProductVO product);
  Stream<List<CartVO>?> fetchCartProductList();
  Future<void> increaseProductQuantity(CartVO cartVO);
  Future<void> decreaseProductQuantity(CartVO cartVO);
  ///whist list
  Future<void> addToFavourites(ProductVO product);
  Future<void> removeFromWhistList(String productId);
  Stream<List<ProductVO>?> fetchWhistList();
  Future<bool> isFavourite(String productId);

}