import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

/// A button widget that navigates to the [HomeScreen] when pressed.
///
/// The [RestaurantButton] displays an icon and a label "Add Restaurants".
/// It uses a custom style with a deep orange background, padding,
/// and rounded corners.
///
/// Example usage:
/// ```dart
/// RestaurantButton(icon: Icon(Icons.add))
/// ```
class RestaurantButton extends StatelessWidget {
  /// The icon to display on the button.
  final Icon? icon;

  /// Creates a [RestaurantButton].
  ///
  /// The [icon] parameter must not be null.
  const RestaurantButton({super.key, required this.icon});

  /// Builds the button widget.
  ///
  /// When pressed, it navigates to the [HomeScreen] with a fade transition.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
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
      },
      icon: icon,
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
