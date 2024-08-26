// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVO _$ProductVOFromJson(Map<String, dynamic> json) => ProductVO(
      productId: json['productId'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      stock: (json['stock'] as num?)?.toInt(),
      discountPercent: (json['discountPercent'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProductVOToJson(ProductVO instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'stock': instance.stock,
      'discountPercent': instance.discountPercent,
      'description': instance.description,
    };
