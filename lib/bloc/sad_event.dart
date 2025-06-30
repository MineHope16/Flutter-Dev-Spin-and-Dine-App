part of 'sad_bloc.dart';

/// Base class for all events handled by [SadBloc].
@immutable
sealed class SadEvent {}

/// Event to load the initial state with the current restaurant list.
///
/// Dispatched when the app or a relevant screen is first opened.
final class SadInitialEvent extends SadEvent {}

/// Event triggered when the user submits a list of restaurant names to add.
///
/// - [restaurantNames]: The list of restaurant names entered by the user.
/// - Ensures no duplicate names (case-insensitive) are added to the list.
final class ProceedButtonClickedEvent extends SadEvent {
  final List<String> restaurantNames;

  ProceedButtonClickedEvent({required this.restaurantNames});
}

/// Event triggered when the user removes a restaurant from the list.
///
/// - [removedRestaurantName]: The name of the restaurant to remove.
/// - Used to update the list and show a SnackBar with an undo option.
final class RemoveButtonClickedEvent extends SadEvent {
  final String removedRestaurantName;

  RemoveButtonClickedEvent({required this.removedRestaurantName});
}

/// Event triggered when the user clicks "Undo" after removing a restaurant.
///
/// - [addRestaurantName]: The name of the restaurant to restore to the list.
final class UndoButtonClickedEvent extends SadEvent {
  final String addRestaurantName;

  UndoButtonClickedEvent({required this.addRestaurantName});
}

/// Event triggered when the user taps the dice/spin button to pick a random restaurant.
///
/// Used to display a randomly selected restaurant from the current list.
final class DiceButtonClickedEvent extends SadEvent {}

/// Event triggered when the user taps "Spin Again" to re-pick a random restaurant.
///
/// Used to show a loading animation and then display a new random pick.
final class SpinAgainButtonClickEvent extends SadEvent {}
