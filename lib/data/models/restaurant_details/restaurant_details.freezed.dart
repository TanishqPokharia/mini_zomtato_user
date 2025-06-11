// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantDetailsModel {

 String get id; String get name; String get location; List<RestaurantMenuItemModel> get menu;
/// Create a copy of RestaurantDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantDetailsModelCopyWith<RestaurantDetailsModel> get copyWith => _$RestaurantDetailsModelCopyWithImpl<RestaurantDetailsModel>(this as RestaurantDetailsModel, _$identity);

  /// Serializes this RestaurantDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.menu, menu));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,location,const DeepCollectionEquality().hash(menu));

@override
String toString() {
  return 'RestaurantDetailsModel(id: $id, name: $name, location: $location, menu: $menu)';
}


}

/// @nodoc
abstract mixin class $RestaurantDetailsModelCopyWith<$Res>  {
  factory $RestaurantDetailsModelCopyWith(RestaurantDetailsModel value, $Res Function(RestaurantDetailsModel) _then) = _$RestaurantDetailsModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String location, List<RestaurantMenuItemModel> menu
});




}
/// @nodoc
class _$RestaurantDetailsModelCopyWithImpl<$Res>
    implements $RestaurantDetailsModelCopyWith<$Res> {
  _$RestaurantDetailsModelCopyWithImpl(this._self, this._then);

  final RestaurantDetailsModel _self;
  final $Res Function(RestaurantDetailsModel) _then;

/// Create a copy of RestaurantDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,Object? menu = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,menu: null == menu ? _self.menu : menu // ignore: cast_nullable_to_non_nullable
as List<RestaurantMenuItemModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RestaurantDetailsModel implements RestaurantDetailsModel {
  const _RestaurantDetailsModel({required this.id, required this.name, required this.location, required final  List<RestaurantMenuItemModel> menu}): _menu = menu;
  factory _RestaurantDetailsModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailsModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String location;
 final  List<RestaurantMenuItemModel> _menu;
@override List<RestaurantMenuItemModel> get menu {
  if (_menu is EqualUnmodifiableListView) return _menu;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menu);
}


/// Create a copy of RestaurantDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantDetailsModelCopyWith<_RestaurantDetailsModel> get copyWith => __$RestaurantDetailsModelCopyWithImpl<_RestaurantDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._menu, _menu));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,location,const DeepCollectionEquality().hash(_menu));

@override
String toString() {
  return 'RestaurantDetailsModel(id: $id, name: $name, location: $location, menu: $menu)';
}


}

/// @nodoc
abstract mixin class _$RestaurantDetailsModelCopyWith<$Res> implements $RestaurantDetailsModelCopyWith<$Res> {
  factory _$RestaurantDetailsModelCopyWith(_RestaurantDetailsModel value, $Res Function(_RestaurantDetailsModel) _then) = __$RestaurantDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String location, List<RestaurantMenuItemModel> menu
});




}
/// @nodoc
class __$RestaurantDetailsModelCopyWithImpl<$Res>
    implements _$RestaurantDetailsModelCopyWith<$Res> {
  __$RestaurantDetailsModelCopyWithImpl(this._self, this._then);

  final _RestaurantDetailsModel _self;
  final $Res Function(_RestaurantDetailsModel) _then;

/// Create a copy of RestaurantDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,Object? menu = null,}) {
  return _then(_RestaurantDetailsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,menu: null == menu ? _self._menu : menu // ignore: cast_nullable_to_non_nullable
as List<RestaurantMenuItemModel>,
  ));
}


}

// dart format on
