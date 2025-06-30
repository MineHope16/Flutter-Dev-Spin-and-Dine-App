part of 'sad_bloc.dart';

/// Base class for all states emitted by [SadBloc].
@immutable
sealed class SadState {}

/// Base class for action states that trigger one-off UI effects (e.g., SnackBars, navigation).
sealed class SadActionState extends SadState {}

/// The initial state of the app or feature.
///
/// Emitted when the bloc is first created or reset.
final class SadInitial extends SadState {}

/// State containing the current list of restaurants.
///
/// Emitted after loading, adding, or undoing changes to the restaurant list.
/// - [restaurantList]: The current list of restaurant names.
final class SadLoadedState extends SadState {
  final List<String> restaurantList;

  SadLoadedState({required this.restaurantList});
}

/// Action state used to show a SnackBar when a restaurant is removed, with undo support.
///
/// - [removedRestaurantName]: The name of the restaurant that was removed.
final class ShowRemovedRestaurantNamesState extends SadActionState {
  final String removedRestaurantName;

  ShowRemovedRestaurantNamesState({required this.removedRestaurantName});
}

/// Action state used to display the randomly picked restaurant.
///
/// - [selectedRestaurant]: The name of the restaurant selected by the picker.
final class RestaurantPickerState extends SadActionState {
  final String selectedRestuarant;
  final bool isLoading;

  RestaurantPickerState({
    required this.selectedRestuarant,
    required this.isLoading,
  });
}
