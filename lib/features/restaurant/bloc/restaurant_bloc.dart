import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_spin_and_dine/data/restaurant_list.dart';
import 'package:meta/meta.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantInitialEvent>(restaurantInitialEvent);
    on<RestaurantRemoveButtonClickedEvent>(restaurantRemoveButtonClicked);
    on<AddRestaurantButtonClickedEvent>(addRestaurantButtonClickedEvent);
    on<AddRemovedRestaurantEvent>(addRemovedRestaurantEvent);
    on<DiceButtonClickedEvent>(diceButtonClickedEvent);
    on<ShowLoaderEvent>(showLoaderEvent);
  }

  FutureOr<void> restaurantInitialEvent(
    RestaurantInitialEvent event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantLoadedState(restaurants: restaurants));
  }

  FutureOr<void> restaurantRemoveButtonClicked(
    RestaurantRemoveButtonClickedEvent event,
    Emitter<RestaurantState> emit,
  ) {
    restaurants.remove(event.removedRestaurantName);
    emit(RestaurantLoadedState(restaurants: restaurants));
    emit(RestaurantRemovedState(removedName: event.removedRestaurantName));
  }

  FutureOr<void> addRestaurantButtonClickedEvent(
    AddRestaurantButtonClickedEvent event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantNavigateToHomeState());
  }

  FutureOr<void> addRemovedRestaurantEvent(
    AddRemovedRestaurantEvent event,
    Emitter<RestaurantState> emit,
  ) {
    restaurants.add(event.restaurantName);
  }

  FutureOr<void> diceButtonClickedEvent(
    DiceButtonClickedEvent event,
    Emitter<RestaurantState> emit,
  ) {
    final String selectedRestaurants =
        restaurants[Random().nextInt(restaurants.length)];
    emit(
      ShowSelectedResatuarantState(selectectRestaurant: selectedRestaurants),
    );
  }

  FutureOr<void> showLoaderEvent(
    ShowLoaderEvent event,
    Emitter<RestaurantState> emit,
  ) {
    emit(ShowLoaderState(isLoading: event.isLoading));
  }
}
