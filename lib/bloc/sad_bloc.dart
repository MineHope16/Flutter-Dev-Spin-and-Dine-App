import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sad_event.dart';
part 'sad_state.dart';

class SadBloc extends Bloc<SadEvent, SadState> {
  List<String> restaurantList = [];
  SadBloc() : super(SadInitial()) {
    on<ProceedButtonClickedEvent>(proceedButtonClickedEvent);
  }

  FutureOr<void> proceedButtonClickedEvent(
    ProceedButtonClickedEvent event,
    Emitter<SadState> emit,
  ) {
    if (restaurantList.isNotEmpty) {
      final existingNames = restaurantList.map((e) => e.toLowerCase()).toList();
      print(existingNames);
      final newNames = event.restaurantNames
          .where((e) => !existingNames.contains(e.toLowerCase()))
          .toList();
      print(newNames);

      if (newNames.isNotEmpty) {
        for (var name in newNames) {
          restaurantList.add(name);
        }
      }
    } else {
      for (var name in event.restaurantNames) {
        restaurantList.add(name);
      }
    }
  }
}
