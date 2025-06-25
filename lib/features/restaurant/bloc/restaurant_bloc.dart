import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_spin_and_dine/data/restaurant_list.dart';
import 'package:meta/meta.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantInitialEvent>(restaurantInitialEvent);
    on<RestaurantRemoveButtonClicked>(restaurantRemoveButtonClicked);
  }

  FutureOr<void> restaurantInitialEvent(
    RestaurantInitialEvent event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantLoadedState(restaurants: restaurants));
  }

  FutureOr<void> restaurantRemoveButtonClicked(
    RestaurantRemoveButtonClicked event,
    Emitter<RestaurantState> emit,
  ) {
    restaurants.remove(event.restaurantName);
    emit(RestaurantLoadedState(restaurants: restaurants));
  }
}
