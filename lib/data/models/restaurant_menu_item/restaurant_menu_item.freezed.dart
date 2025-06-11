// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantMenuItemModel {

 String get id; String get restaurantId; String get name; double get price; String get description; MenuItemType get menuItemType; PalateType get palateType;
/// Create a copy of RestaurantMenuItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantMenuItemModelCopyWith<RestaurantMenuItemModel> get copyWith => _$RestaurantMenuItemModelCopyWithImpl<RestaurantMenuItemModel>(this as RestaurantMenuItemModel, _$identity);

  /// Serializes this RestaurantMenuItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantMenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.menuItemType, menuItemType) || other.menuItemType == menuItemType)&&(identical(other.palateType, palateType) || other.palateType == palateType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,price,description,menuItemType,palateType);

@override
String toString() {
  return 'RestaurantMenuItemModel(id: $id, restaurantId: $restaurantId, name: $name, price: $price, description: $description, menuItemType: $menuItemType, palateType: $palateType)';
}


}

/// @nodoc
abstract mixin class $RestaurantMenuItemModelCopyWith<$Res>  {
  factory $RestaurantMenuItemModelCopyWith(RestaurantMenuItemModel value, $Res Function(RestaurantMenuItemModel) _then) = _$RestaurantMenuItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String restaurantId, String name, double price, String description, MenuItemType menuItemType, PalateType palateType
});




}
/// @nodoc
class _$RestaurantMenuItemModelCopyWithImpl<$Res>
    implements $RestaurantMenuItemModelCopyWith<$Res> {
  _$RestaurantMenuItemModelCopyWithImpl(this._self, this._then);

  final RestaurantMenuItemModel _self;
  final $Res Function(RestaurantMenuItemModel) _then;

/// Create a copy of RestaurantMenuItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? restaurantId = null,Object? name = null,Object? price = null,Object? description = null,Object? menuItemType = null,Object? palateType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,menuItemType: null == menuItemType ? _self.menuItemType : menuItemType // ignore: cast_nullable_to_non_nullable
as MenuItemType,palateType: null == palateType ? _self.palateType : palateType // ignore: cast_nullable_to_non_nullable
as PalateType,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RestaurantMenuItemModel implements RestaurantMenuItemModel {
  const _RestaurantMenuItemModel({required this.id, required this.restaurantId, required this.name, required this.price, required this.description, required this.menuItemType, required this.palateType});
  factory _RestaurantMenuItemModel.fromJson(Map<String, dynamic> json) => _$RestaurantMenuItemModelFromJson(json);

@override final  String id;
@override final  String restaurantId;
@override final  String name;
@override final  double price;
@override final  String description;
@override final  MenuItemType menuItemType;
@override final  PalateType palateType;

/// Create a copy of RestaurantMenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantMenuItemModelCopyWith<_RestaurantMenuItemModel> get copyWith => __$RestaurantMenuItemModelCopyWithImpl<_RestaurantMenuItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantMenuItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantMenuItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.menuItemType, menuItemType) || other.menuItemType == menuItemType)&&(identical(other.palateType, palateType) || other.palateType == palateType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,restaurantId,name,price,description,menuItemType,palateType);

@override
String toString() {
  return 'RestaurantMenuItemModel(id: $id, restaurantId: $restaurantId, name: $name, price: $price, description: $description, menuItemType: $menuItemType, palateType: $palateType)';
}


}

/// @nodoc
abstract mixin class _$RestaurantMenuItemModelCopyWith<$Res> implements $RestaurantMenuItemModelCopyWith<$Res> {
  factory _$RestaurantMenuItemModelCopyWith(_RestaurantMenuItemModel value, $Res Function(_RestaurantMenuItemModel) _then) = __$RestaurantMenuItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String restaurantId, String name, double price, String description, MenuItemType menuItemType, PalateType palateType
});




}
/// @nodoc
class __$RestaurantMenuItemModelCopyWithImpl<$Res>
    implements _$RestaurantMenuItemModelCopyWith<$Res> {
  __$RestaurantMenuItemModelCopyWithImpl(this._self, this._then);

  final _RestaurantMenuItemModel _self;
  final $Res Function(_RestaurantMenuItemModel) _then;

/// Create a copy of RestaurantMenuItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? restaurantId = null,Object? name = null,Object? price = null,Object? description = null,Object? menuItemType = null,Object? palateType = null,}) {
  return _then(_RestaurantMenuItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,menuItemType: null == menuItemType ? _self.menuItemType : menuItemType // ignore: cast_nullable_to_non_nullable
as MenuItemType,palateType: null == palateType ? _self.palateType : palateType // ignore: cast_nullable_to_non_nullable
as PalateType,
  ));
}


}

// dart format on
