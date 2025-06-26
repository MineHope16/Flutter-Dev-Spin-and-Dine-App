import 'package:flutter/material.dart';
import '../features/home/ui/home.dart';

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
  final VoidCallback onPressed;

  /// Creates a [RestaurantButton].
  ///
  /// The [icon] parameter must not be null.
  const RestaurantButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  /// Builds the button widget.
  ///
  /// When pressed, it navigates to the [HomeScreen] with a fade transition.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
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
