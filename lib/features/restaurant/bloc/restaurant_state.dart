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

final class RestaurantRemovedState extends RestaurantActionState {}
