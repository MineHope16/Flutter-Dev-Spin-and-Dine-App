part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantState {}

sealed class RestaurantActionState extends RestaurantState {}

final class RestaurantInitial extends RestaurantState {}

final class RestaurantLoadingState extends RestaurantState {}

final class RestaurantLoadedState extends RestaurantState {
  final List<String> restaurants;
  RestaurantLoadedState({required this.restaurants});
}

final class RestaurantErrorState extends RestaurantState {}

final class RestaurantRemovedState extends RestaurantActionState {
  final String removedName;
  RestaurantRemovedState({required this.removedName});
}

final class RestaurantNavigateToHomeState extends RestaurantActionState {}

final class ShowSelectedResatuarantState extends RestaurantState {
  final String selectectRestaurant;

  ShowSelectedResatuarantState({required this.selectectRestaurant});
}

final class ShowLoaderState extends RestaurantActionState {
  final bool isLoading;

  ShowLoaderState({required this.isLoading});
}
