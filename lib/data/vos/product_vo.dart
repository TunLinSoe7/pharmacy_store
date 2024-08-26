import 'package:json_annotation/json_annotation.dart';
part 'product_vo.g.dart';

@JsonSerializable()
class ProductVO{
  @JsonKey(name: 'productId')
  String? productId;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'stock')
  int? stock;
  @JsonKey(name: 'discountPercent')
  int? discountPercent;
  @JsonKey(name: 'description')
  String? description;
  ProductVO({this.productId,this.title,this.image,this.price,this.stock,this.discountPercent,this.description});

  factory ProductVO.fromJson(Map<String,dynamic> json)=>_$ProductVOFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductVOToJson(this);
}