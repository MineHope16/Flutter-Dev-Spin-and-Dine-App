import 'package:flutter/material.dart';
import 'package:flutter_spin_and_dine/screens/app_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../model/restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantsList = Provider.of<RestaurantList>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Restaurants")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: restaurantsList.restaurants.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 3.0,
                      child: Lottie.asset(
                        "assets/empty.json",
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),

                    const SizedBox(height: 50),

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
                    ElevatedButton.icon(
                      onPressed: () {

                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder: (context, animation, secondaryAnimation) => AppScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );

                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Add Restaurants",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: restaurantsList.restaurants.length,
                      itemBuilder: (context, int index) {
                        final String restaurantName =
                            restaurantsList.restaurants[index];

                        return TweenAnimationBuilder(
                          duration: Duration(
                            milliseconds: index * 100,
                          ), // stagger effect
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                (1 - value) * 20,
                              ), // slides upward
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
                                onPressed: () {
                                  final removedName = restaurantName;
                                  restaurantsList.removeAt(restaurantName);

                                  ScaffoldMessenger.of(
                                    context,
                                  ).clearSnackBars();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.grey.shade600,
                                      content: Text(
                                        "$removedName removed",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      duration: const Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                      action: SnackBarAction(
                                        label: "Undo",
                                        onPressed: () {
                                          restaurantsList.addRestaurant(
                                            removedName,
                                          );
                                        },
                                        textColor: Colors.orangeAccent,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
