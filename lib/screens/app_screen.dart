import 'package:flutter/material.dart';
import 'package:flutter_spin_and_dine/model/restaurant.dart';
import 'package:flutter_spin_and_dine/screens/restaurant_screen.dart';
import 'package:provider/provider.dart';

class AppScreen extends StatelessWidget {
  AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    void handleSubmit(context) {
      final input = textController.text;
      if (input.trim().isEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade600,
            content: Text(
              "Please enter atleast one restaurant",
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
      print(names);

      final restaurantProvider = Provider.of<RestaurantList>(
        context,
        listen: false,
      );

      if (restaurantProvider.restaurants.isNotEmpty) {
        final existingNames = restaurantProvider.restaurants
            .map((e) => e.toLowerCase())
            .toList();
        print(existingNames);
        final newNames = names
            .where((e) => !existingNames.contains(e.toLowerCase()))
            .toList();
        print(newNames);

        if (newNames.isNotEmpty) {
          for (var name in newNames) {
            restaurantProvider.addRestaurant(name);
          }
        }
      } else {
        for (var name in names) {
          restaurantProvider.addRestaurant(name);
        }
      }

      textController.clear();
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              RestaurantScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }

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
                        hintText: 'e.g. Domino\'s, Pizza Hut, Taco Bell...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      onSubmitted: (_) => handleSubmit(context),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => handleSubmit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
  }
}
