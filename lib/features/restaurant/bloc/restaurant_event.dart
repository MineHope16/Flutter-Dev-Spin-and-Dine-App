part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantEvent {}

final class RestaurantInitialEvent extends RestaurantEvent {}

final class RestaurantRemoveButtonClicked extends RestaurantEvent {
  final String restaurantName;

  RestaurantRemoveButtonClicked({required this.restaurantName});
}
