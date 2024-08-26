import 'package:flutter/material.dart';

 showSnackBar(BuildContext context){
   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     backgroundColor: Colors.red,
       content: Text('Account not exist!')));
 }
int calculateDiscountedPrice(int originalPrice, int discountPercentage) {
  double discountAmount = originalPrice * (discountPercentage / 100);
  double discountedPrice = originalPrice - discountAmount;
  return discountedPrice.toInt();
}

navigateToScreen(Widget screen,BuildContext context){
  return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>screen));
}