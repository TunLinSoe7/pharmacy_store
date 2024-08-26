import 'package:pharmacy_store/data/model/product_models.dart';
import 'package:pharmacy_store/data/vos/cart_vo.dart';
import 'package:pharmacy_store/data/vos/product_vo.dart';
import 'package:pharmacy_store/network/data_agent/product_data_agent.dart';
import 'package:pharmacy_store/network/data_agent/product_data_agent_impl.dart';

class ProductModelImpl extends ProductModels{
  ProductModelImpl._();
  static final ProductModelImpl _singleton = ProductModelImpl._();
  factory ProductModelImpl()=>_singleton;

  final ProductDataAgent _productDataAgent = ProductDataAgentImpl();
  /// promotion products
  @override
  Stream<List<ProductVO>?> fetchPromotionProductListStream()=>_productDataAgent
      .fetchPromotionProductListStream();
  /// fetch all products
  @override
  Stream<List<ProductVO>?> fetchAllProductListStream()=>_productDataAgent
      .fetchAllProductListStream();
  /// fetch product by id
  @override
  Future<ProductVO> fetchProductById(String id) =>_productDataAgent.fetchProductById(id);
  /// add to cart
  @override
  Future<void> addToCart(ProductVO product) =>_productDataAgent.addProductToCart(product);
  /// fetch cart list
  @override
  Stream<List<CartVO>?> fetchCartProductList() =>_productDataAgent.fetchCartProductList();

  @override
  Future<void> decreaseQuantity(CartVO cartVO) =>_productDataAgent.decreaseProductQuantity(cartVO);

  @override
  Future<void> increaseQuantity(CartVO cartVO) =>_productDataAgent.increaseProductQuantity(cartVO);
  /// add to whist lists
  @override
  Future<void> addToWhistList(ProductVO productVO)=>_productDataAgent.addToFavourites(productVO);

  @override
  Stream<List<ProductVO>?> fetchWhistList() =>_productDataAgent.fetchWhistList();
  @override
  Future<bool> isFavourite(String productId) =>_productDataAgent.isFavourite(productId);

  @override
  Future<void> removeFromWhistList(String productId) =>_productDataAgent.removeFromWhistList(productId);

}