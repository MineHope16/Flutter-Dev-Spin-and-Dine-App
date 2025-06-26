part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantEvent {}

final class RestaurantInitialEvent extends RestaurantEvent {}

final class RestaurantRemoveButtonClickedEvent extends RestaurantEvent {
  final String removedRestaurantName;

  RestaurantRemoveButtonClickedEvent({required this.removedRestaurantName});
}

final class AddRestaurantButtonClickedEvent extends RestaurantEvent {}

final class AddRemovedRestaurantEvent extends RestaurantEvent {
  final String restaurantName;

  AddRemovedRestaurantEvent({required this.restaurantName});
}

final class DiceButtonClickedEvent extends RestaurantEvent {}

final class ShowLoaderEvent extends RestaurantEvent {
  final bool isLoading;

  ShowLoaderEvent({required this.isLoading});
}
