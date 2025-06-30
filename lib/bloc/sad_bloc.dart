import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'sad_event.dart';
part 'sad_state.dart';

/// The [SadBloc] manages the state and business logic for the restaurant selection
/// and picker features in the Spin and Dine app.
///
/// This BLoC handles all user interactions related to the restaurant list,
/// including adding, removing, undoing removals, and picking a random restaurant.
/// It exposes a list of restaurant names and emits states to update the UI
/// in response to user actions.
///
/// ### Events handled:
/// - [SadInitialEvent]: Loads the initial state with the current restaurant list.
/// - [ProceedButtonClickedEvent]: Adds new restaurant names from user input,
///   ensuring no duplicates (case-insensitive).
/// - [RemoveButtonClickedEvent]: Removes a restaurant name and emits a state
///   to show a SnackBar with an undo option.
/// - [UndoButtonClickedEvent]: Restores a previously removed restaurant name.
/// - [DiceButtonClickedEvent]: Picks a random restaurant from the list and emits
///   a state to display it.
/// - [SpinAgainButtonClickEvent]: Triggers a loading animation, then picks and
///   emits a new random restaurant.
///
/// ### States emitted:
/// - [SadInitial]: The initial state.
/// - [SadLoadedState]: Contains the current list of restaurants.
/// - [ShowRemovedRestaurantNamesState]: Used for showing a SnackBar when a
///   restaurant is removed, with undo support.
/// - [RestaurantPickerState]: Used to display the randomly picked restaurant.
///
/// ### Usage:
/// The [SadBloc] is provided at the top level of the app using [BlocProvider].
/// UI screens such as [HomeScreen] and [RestaurantScreen] interact with this bloc
/// to update and display the restaurant list, and to handle user actions like
/// adding, removing, and spinning for a random restaurant.
///
/// Example:
/// ```dart
/// BlocProvider(
///   create: (_) => SadBloc(),
///   child: MyApp(),
/// )
/// ```
///
/// See also:
/// - [SadEvent] for all possible events.
/// - [SadState] for all possible states.

class SadBloc extends Bloc<SadEvent, SadState> {
  List<String> restaurantList = [];
  late String selectedRestaurant;

  SadBloc() : super(SadInitial()) {
    on<SadInitialEvent>(sadInitialEvent);
    on<ProceedButtonClickedEvent>(proceedButtonClickedEvent);
    on<RemoveButtonClickedEvent>(removeButtonClickedEvent);
    on<UndoButtonClickedEvent>(undoButtonClickedEvent);
    on<DiceButtonClickedEvent>(diceButtonClickedEvent);
    on<SpinAgainButtonClickEvent>(spinAgainButtonClickEvent);
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> sadInitialEvent(
    SadInitialEvent event,
    Emitter<SadState> emit,
  ) {
    emit(SadLoadedState(restaurantList: restaurantList));
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> proceedButtonClickedEvent(
    ProceedButtonClickedEvent event,
    Emitter<SadState> emit,
  ) {
    if (restaurantList.isNotEmpty) {
      final existingNames = restaurantList.map((e) => e.toLowerCase()).toList();

      final newNames = event.restaurantNames
          .where((e) => !existingNames.contains(e.toLowerCase()))
          .toList();

      if (newNames.isNotEmpty) {
        restaurantList.addAll(newNames);
      }
    } else {
      restaurantList.addAll(event.restaurantNames);
    }
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> removeButtonClickedEvent(
    RemoveButtonClickedEvent event,
    Emitter<SadState> emit,
  ) {
    restaurantList.remove(event.removedRestaurantName);

    emit(
      ShowRemovedRestaurantNamesState(
        removedRestaurantName: event.removedRestaurantName,
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> undoButtonClickedEvent(
    UndoButtonClickedEvent event,
    Emitter<SadState> emit,
  ) {
    restaurantList.add(event.addRestaurantName);

    emit(SadLoadedState(restaurantList: restaurantList));
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> diceButtonClickedEvent(
    DiceButtonClickedEvent event,
    Emitter<SadState> emit,
  ) {
    selectedRestaurant =
        restaurantList[Random().nextInt(restaurantList.length)];

    emit(
      RestaurantPickerState(
        selectedRestuarant: selectedRestaurant,
        isLoading: false,
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────────────────────
  FutureOr<void> spinAgainButtonClickEvent(
    SpinAgainButtonClickEvent event,
    Emitter<SadState> emit,
  ) async {
    emit(
      RestaurantPickerState(selectedRestuarant: '', isLoading: true),
    ); // Empty to show loading

    await Future.delayed(Duration(seconds: 2));

    selectedRestaurant =
        restaurantList[Random().nextInt(restaurantList.length)];

    emit(
      RestaurantPickerState(
        selectedRestuarant: selectedRestaurant,
        isLoading: false,
      ),
    );
  }
}
