import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
// Use 'implements' not 'extends'.
// Use 'with' for the generated mixin, not 'extends'.
abstract class RestaurantModel with _$RestaurantModel implements Restaurant {
  // Use the standard const factory constructor.
  // Declare the fields here directly.
  const factory RestaurantModel({
    required String id,
    required String name,
    required double rating,
    required String location,
    required String imageUrl,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  factory RestaurantModel.fromEntity(Restaurant restaurant) {
    return RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      rating: restaurant.rating,
      location: restaurant.location,
      imageUrl: restaurant.imageUrl,
    );
  }
}
