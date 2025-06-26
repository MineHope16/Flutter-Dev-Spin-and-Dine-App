part of 'sad_bloc.dart';

@immutable
sealed class SadEvent {}

final class ProceedButtonClickedEvent extends SadEvent {
  final List<String> restaurantNames;

  ProceedButtonClickedEvent({required this.restaurantNames});
}
