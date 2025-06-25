part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeInitialEvent extends HomeEvent {}

final class HomeProceedButtonClicked extends HomeEvent {
  final List<String> namesToBeAdded;

  HomeProceedButtonClicked({required this.namesToBeAdded});
}
