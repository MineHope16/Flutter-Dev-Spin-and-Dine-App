part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {}

final class HomeErrorState extends HomeState {}

final class HomeNavigateToRestaurant extends HomeActionState {}

final class RestauranNavigateToHome extends HomeActionState {}
