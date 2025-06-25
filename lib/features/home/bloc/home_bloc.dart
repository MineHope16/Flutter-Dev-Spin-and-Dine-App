import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_spin_and_dine/data/restaurant_list.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProceedButtonClicked>(homeProceedButtonClicked);
  }

  FutureOr<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedState());
  }

  FutureOr<void> homeProceedButtonClicked(
    HomeProceedButtonClicked event,
    Emitter<HomeState> emit,
  ) {
    if (restaurants.isNotEmpty) {
      final existingNames = restaurants.map((e) => e.toLowerCase()).toList();

      final newNames = event.namesToBeAdded
          .where((e) => !existingNames.contains(e.toLowerCase()))
          .toList();

      if (newNames.isNotEmpty) {
        for (var name in newNames) {
          restaurants.add(name);
        }
      }
    } else {
      for (var name in event.namesToBeAdded) {
        restaurants.add(name);
      }
    }
    print("$restaurants");

    emit(HomeNavigateToRestaurant());
  }
}
