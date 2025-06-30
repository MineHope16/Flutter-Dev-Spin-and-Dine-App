import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/bloc/sad_bloc.dart';
import 'package:lottie/lottie.dart';

/// A bottom sheet widget that displays the randomly picked restaurant and allows spinning again.
///
/// This widget is used to show the result of the restaurant picker feature.
/// When opened, it triggers a random restaurant selection via [DiceButtonClickedEvent].
/// It listens to [SadBloc] for [RestaurantPickerState] and displays the selected restaurant,
/// a loading animation if spinning, and a "Spin Again" button to pick another restaurant.
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (context) => BottomSheetWidget(),
/// );
/// ```
class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

/// State for [BottomSheetWidget].
///
/// - On init, dispatches [DiceButtonClickedEvent] to pick a restaurant.
/// - Uses [BlocBuilder] to rebuild when [SadBloc] emits a [SadActionState].
/// - Displays the picked restaurant, a loading animation, or a "Spin Again" button.
class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  void initState() {
    super.initState();
    // Triggers the initial random pick when the bottom sheet opens.
    context.read<SadBloc>().add(DiceButtonClickedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SadBloc, SadState>(
      buildWhen: (previous, current) => current is SadActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantPickerState:
            final successState = state as RestaurantPickerState;
            return Container(
              height: 400,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "🎉 Today's Pick!",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  successState.isLoading
                      ? Transform.scale(
                          scale: 1.5,
                          child: Lottie.asset(
                            "assets/images/loader.json",
                            height: 80,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Text(
                          successState.selectedRestuarant,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<SadBloc>().add(SpinAgainButtonClickEvent());
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Spin Again", style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }
}
