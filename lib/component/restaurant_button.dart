import 'package:flutter/material.dart';
import '../features/home/ui/home.dart';

/// A button widget that navigates to the [AppScreen] when pressed.
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
  RestaurantButton({required this.icon});

  /// Builds the button widget.
  ///
  /// When pressed, it navigates to the [AppScreen] with a fade transition.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                AppScreen(),
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
