import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:lottie/lottie.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final RestaurantBloc restaurantBloc = RestaurantBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    restaurantBloc.add(DiceButtonClickedEvent());
  }

  @override
  void dispose() {
    restaurantBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantBloc, RestaurantState>(
      bloc: restaurantBloc,
      listenWhen: (previous, current) => current is RestaurantActionState,
      buildWhen: (previous, current) => current is! RestaurantActionState,
      listener: (context, state) {
        if (state is ShowLoaderState) {
          setState(() {
            isLoading = state.isLoading;
          });
        }
      },
      builder: (context, state) {
        if (state is ShowSelectedResatuarantState) {
          return Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "🎉 Today's Pick!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                isLoading
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
                        state.selectectRestaurant,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () async {
                    restaurantBloc.add(ShowLoaderEvent(isLoading: true));
                    await Future.delayed(const Duration(seconds: 3));
                    restaurantBloc.add(ShowLoaderEvent(isLoading: false));
                    restaurantBloc.add(DiceButtonClickedEvent());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    "Spin Again",
                    style: TextStyle(fontSize: 18),
                  ),
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
        }

        return const SizedBox(height: 60, child: Text('YOOOOOOOO'));
      },
    );
  }
}
