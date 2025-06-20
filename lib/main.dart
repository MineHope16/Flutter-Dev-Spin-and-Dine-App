import 'package:flutter/material.dart';
import 'package:flutter_spin_and_dine/screens/app_screen.dart';
import 'package:flutter_spin_and_dine/screens/restaurant_screen.dart';
import 'package:provider/provider.dart';

import 'model/restaurant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantList(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orangeAccent,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AppScreen(),
          '/restaurant': (context) => const RestaurantScreen(),
        },
      ),
    );
  }
}
