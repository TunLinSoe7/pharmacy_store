import 'package:json_annotation/json_annotation.dart';
part 'cart_vo.g.dart';
@JsonSerializable()
class CartVO{
  @JsonKey(name: 'product_id')
  String? productId;
  @JsonKey(name: 'product_title')
  String? productTitle;
  @JsonKey(name: 'product_quantity')
  int? productQuantity;
  @JsonKey(name: 'product_price')
  int? productPrice;
  @JsonKey(name: 'total_price')
  int? totalPrice;
  @JsonKey(name: 'product_image')
  String? productImage;
  CartVO({this.productId,this.productTitle,this.totalPrice,this.productPrice,this.productImage,this.productQuantity});
  factory CartVO.fromJson(Map<String,dynamic> json)=>_$CartVOFromJson(json);
  Map<String,dynamic> toJson()=>_$CartVOToJson(this);
}