import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/vos/product_vo.dart';
import 'package:pharmacy_store/network/data_agent/product_data_agent.dart';
import 'package:pharmacy_store/utils/helper_functions/helper_functions.dart';
import '../../data/vos/cart_vo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDataAgentImpl extends ProductDataAgent{
  ProductDataAgentImpl._();
  static final ProductDataAgentImpl _singleton = ProductDataAgentImpl._();
  factory ProductDataAgentImpl()=> _singleton;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // fetch promotion product list
  @override
  Stream<List<ProductVO>?> fetchPromotionProductListStream() =>_firebaseFirestore
      .collection('products')
      .where('discountPercent',isGreaterThan: 0)
      .snapshots()
      .map((querySnapshot) {
        return querySnapshot.docs.map((documentSnapshot) => ProductVO.fromJson(documentSnapshot.data())).toList();
  });

  @override
  Stream<List<ProductVO>?> fetchAllProductListStream() =>_firebaseFirestore
      .collection('products')
      .snapshots()
      .map((event) {
        return event.docs.map((documentSnapshot) => ProductVO.fromJson(documentSnapshot.data())).toList();
  });

  @override
  Future<ProductVO> fetchProductById(String id) =>_firebaseFirestore
      .collection('products')
      .doc(id)
      .get()
      .then((value) => ProductVO.fromJson(Map<String,dynamic>.from(value.data() as Map)));


  @override
  Future<void> addProductToCart(ProductVO product) async {
    try {
      int? price =  product.discountPercent! > 0?calculateDiscountedPrice(product.price ?? 0, product.discountPercent ?? 0):product.price;
      // Create CartVO instance
      CartVO cartItem = CartVO(
        productId: product.productId,
        productTitle: product.title,
        productQuantity: 1,
        productPrice: price,
        totalPrice: price,
        productImage: product.image,
      );
       var user = _auth.currentUser!;

       CollectionReference cartCollection = _firebaseFirestore.collection('users')
      .doc(user.uid)
      .collection('cart');
       QuerySnapshot querySnapshot = await cartCollection.where('product_id',isEqualTo: product.productId)
      .get();
       if(querySnapshot.docs.isNotEmpty){
         DocumentSnapshot existingItem = querySnapshot.docs.first;
         int currentQuantity = existingItem['product_quantity'];
         int newQuantity = currentQuantity + 1;
         int newTotalPrice = newQuantity * price!;
         await existingItem.reference.update(({
           'product_quantity':newQuantity,
           'total_price':newTotalPrice,
         }));
         Fluttertoast.showToast(msg: 'Update Product Quantity In Cart.',
             toastLength: Toast.LENGTH_SHORT
         );
       }else{
         await _firebaseFirestore.collection('users')
             .doc(user.uid)
             .collection('cart')
             .add(cartItem.toJson());
         Fluttertoast.showToast(msg: 'Add To Cart Successfully.',
             toastLength: Toast.LENGTH_SHORT
         );
       }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Oh!Try again!.',
          toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red.withOpacity(0.5),
      );
    }
  }

  /// fetch cart list
  @override
  Stream<List<CartVO>?> fetchCartProductList() {
    var currentUser = _auth.currentUser;
    return _firebaseFirestore.collection('users')
        .doc(currentUser!.uid)
        .collection('cart')
        .snapshots()
        .map((event) => event.docs.map((document) => CartVO.fromJson(document.data())).toList());
  }

  ///decreaseProductQuantity

  @override
  Future<void> decreaseProductQuantity(CartVO cartVO) async {
    try {
      var user = _auth.currentUser!;
      CollectionReference cartCollection = _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('cart');

      QuerySnapshot querySnapshot = await cartCollection
          .where('product_id', isEqualTo: cartVO.productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot existingItem = querySnapshot.docs.first;
        int currentQuantity = existingItem['product_quantity'];

        if (currentQuantity > 1) {
          int newQuantity = currentQuantity - 1;
          int newTotalPrice = newQuantity * cartVO.productPrice!;

          await existingItem.reference.update({
            'product_quantity': newQuantity,
            'total_price': newTotalPrice,
          });

          Fluttertoast.showToast(
            msg: 'Decreased Product Quantity in Cart.',
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          await existingItem.reference.delete();

          Fluttertoast.showToast(
            msg: 'Removed Product from Cart.',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Oh! Try again!',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red.withOpacity(0.5),
      );
    }
  }
  /// increase product quantity
  @override
  Future<void> increaseProductQuantity(CartVO cartVO) async{
    try{
      var currentUser = _auth.currentUser!.uid;
       CollectionReference cartCollection = _firebaseFirestore
      .collection('users')
      .doc(currentUser)
      .collection('cart');
       QuerySnapshot querySnapshot = await cartCollection.where('product_id',isEqualTo: cartVO.productId).get();
       if(querySnapshot.docs.isNotEmpty){
         DocumentSnapshot existingItem = querySnapshot.docs.first;
         int currentQuantity = existingItem['product_quantity'];
         int newQuantity = currentQuantity +1;
         int newTotalPrice = cartVO.productPrice! * newQuantity;

         await existingItem.reference.update(
          {
            'product_quantity':newQuantity,
            'total_price':newTotalPrice,
          }
         );
       }

    }catch(e){
      throw Exception(e.toString());
    }
  }


}