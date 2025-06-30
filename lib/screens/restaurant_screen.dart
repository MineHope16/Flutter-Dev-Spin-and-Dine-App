import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/bloc/sad_bloc.dart';
import 'package:flutter_spin_and_dine/component/bottom_sheet_widget.dart';
import 'package:lottie/lottie.dart';
import '../component/restaurant_button.dart';

// ignore: must_be_immutable
class RestaurantScreen extends StatefulWidget {
  RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    context.read<SadBloc>().add(SadInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Restaurants")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<SadBloc, SadState>(
          listenWhen: (previous, current) => current is SadActionState,
          buildWhen: (previous, current) => current is! SadActionState,
          listener: (context, state) {
            if (state is ShowRemovedRestaurantNamesState) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey.shade600,
                  content: Text("${state.removedRestaurantName} removed"),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () => context.read<SadBloc>().add(
                      UndoButtonClickedEvent(
                        addRestaurantName: state.removedRestaurantName,
                      ),
                    ),
                    textColor: Colors.orangeAccent,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case SadLoadedState:
                return context.watch<SadBloc>().restaurantList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 3.0,
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
                              itemCount: context
                                  .watch<SadBloc>()
                                  .restaurantList
                                  .length,
                              itemBuilder: (context, int index) {
                                final String restaurantName = context
                                    .watch<SadBloc>()
                                    .restaurantList[index];
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
                                          context.read<SadBloc>().add(
                                            RemoveButtonClickedEvent(
                                              removedRestaurantName:
                                                  removedName,
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
                              RestaurantButton(icon: null),
                              const SizedBox(height: 20),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                    90,
                                  ), // match shape
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
                return SizedBox(
                  child: Center(
                    child: Text(
                      "Hey, There Dont Worry We'll Get It Fixed....Sit Back, Eat Five Star and Do Nothing 😂",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
