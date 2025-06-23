import 'package:flutter/foundation.dart';

class RestaurantList extends ChangeNotifier {
  List<String> _restaurants = [];

  List<String> get restaurants => _restaurants;

  void addRestaurant(String restaurant) {
    _restaurants.add(restaurant);
    notifyListeners();
  }

  void removeAt(String restaurant) {
    _restaurants.remove(restaurant);
    notifyListeners();
  }
}
