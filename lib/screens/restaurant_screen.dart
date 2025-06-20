import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        Navigator.pushReplacementNamed(context, '/');
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
                        final String name = restaurantsList.restaurants[index];
                        return ListTile(
                          leading: const Icon(Icons.restaurant),
                          title: Text(name),
                          trailing: IconButton(
                            onPressed: () {
                              restaurantsList.removeAt(name);
                            },
                            icon: const Icon(Icons.close),
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
