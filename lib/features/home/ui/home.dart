import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/features/home/bloc/home_bloc.dart';
import 'package:flutter_spin_and_dine/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:flutter_spin_and_dine/features/restaurant/ui/restaurant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void handleSubmit(
    BuildContext context,
    TextEditingController textController,
  ) {
    final input = textController.text;

    if (input.trim().isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade600,
          content: Text(
            "Please enter at least one restaurant",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final names = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    homeBloc.add(HomeProceedButtonClicked(namesToBeAdded: names));
    textController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,

      listener: (context, state) {
        if (state is HomeNavigateToRestaurant) {
          FocusScope.of(context).unfocus();

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  BlocProvider(
                    create: (context) => RestaurantBloc(),
                    child: RestaurantScreen(),
                  ),
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
          case HomeLoadedState:
            debugPrint("HomeLoadedStateAccessed");
            final TextEditingController textController =
                TextEditingController();

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(title: const Text('Spin and Dine')),

              body: Padding(
                padding: const EdgeInsets.all(24.0),

                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.orange[100],

                      child: Padding(
                        padding: const EdgeInsets.all(24.0),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Enter your restaurant choices",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextField(
                              controller: textController,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText:
                                    'e.g. Domino\'s, Pizza Hut, Taco Bell...',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              onSubmitted: (_) {
                                handleSubmit(context, textController);
                              },
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  handleSubmit(context, textController);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Proceed",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }
}
