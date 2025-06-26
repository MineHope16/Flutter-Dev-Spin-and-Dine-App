import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/component/restaurant_button.dart';
import 'package:flutter_spin_and_dine/features/home/ui/home.dart';
import 'package:flutter_spin_and_dine/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:flutter_spin_and_dine/features/restaurant/ui/bottom_sheet_widget.dart';
import 'package:lottie/lottie.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantBloc restaurantBloc = RestaurantBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    restaurantBloc.add(RestaurantInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child: Text("Restaurant Picker"))),
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,

        listenWhen: (previous, current) => current is RestaurantActionState,

        buildWhen: (previous, current) => current is! RestaurantActionState,

        listener: (context, state) {
          if (state is RestaurantRemovedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${state.removedName} removed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey.shade600,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    restaurantBloc.add(
                      AddRemovedRestaurantEvent(
                        restaurantName: state.removedName,
                      ),
                    );
                  },
                  textColor: Colors.amber,
                ),
              ),
            );
          }

          if (state is RestaurantNavigateToHomeState) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              ),
            );
          }
        },

        builder: (context, state) {
          switch (state.runtimeType) {
            case RestaurantLoadedState:
              final successState = state as RestaurantLoadedState;
              return successState.restaurants.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Lottie.asset(
                              "assets/images/empty.json",
                              fit: BoxFit.fill,
                              repeat: true,
                              animate: true,
                            ),
                          ),

                          const SizedBox(height: 60),

                          const Text(
                            "No restaurants selected",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 24),

                          RestaurantButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              restaurantBloc.add(
                                AddRestaurantButtonClickedEvent(),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 450,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: successState.restaurants.length,
                            itemBuilder: (context, int index) {
                              final String restaurantName =
                                  successState.restaurants[index];

                              return TweenAnimationBuilder(
                                duration: Duration(milliseconds: index * 100),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) => Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, (1 - value) * 20),
                                    child: child,
                                  ),
                                ),

                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  surfaceTintColor: Colors.orangeAccent,
                                  child: ListTile(
                                    leading: const Icon(Icons.restaurant),

                                    title: Text(restaurantName),

                                    trailing: IconButton(
                                      tooltip: "Remove",
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        final removedName = restaurantName;
                                        restaurantBloc.add(
                                          RestaurantRemoveButtonClickedEvent(
                                            removedRestaurantName: removedName,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 30),

                        Column(
                          children: [
                            RestaurantButton(
                              icon: null,
                              onPressed: () {
                                restaurantBloc.add(
                                  AddRestaurantButtonClickedEvent(),
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(90),
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetWidget();
                                    },
                                  );
                                },
                                child: Image.asset(
                                  "assets/images/dice.png",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
