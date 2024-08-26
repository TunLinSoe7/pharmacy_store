// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartVO _$CartVOFromJson(Map<String, dynamic> json) => CartVO(
      productId: json['product_id'] as String?,
      productTitle: json['product_title'] as String?,
      totalPrice: (json['total_price'] as num?)?.toInt(),
      productPrice: (json['product_price'] as num?)?.toInt(),
      productImage: json['product_image'] as String?,
      productQuantity: (json['product_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartVOToJson(CartVO instance) => <String, dynamic>{
      'product_id': instance.productId,
      'product_title': instance.productTitle,
      'product_quantity': instance.productQuantity,
      'product_price': instance.productPrice,
      'total_price': instance.totalPrice,
      'product_image': instance.productImage,
    };
