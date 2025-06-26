import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/bloc/sad_bloc.dart';
import 'package:lottie/lottie.dart';
import '../component/restaurant_button.dart';
import 'dart:math';

// ignore: must_be_immutable
class RestaurantScreen extends StatelessWidget {
  RestaurantScreen({super.key});
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sadBloc = context.watch<SadBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Restaurants")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<SadBloc, SadState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return sadBloc.restaurantList.isEmpty
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
                          itemCount: sadBloc.restaurantList.length,
                          itemBuilder: (context, int index) {
                            final String restaurantName =
                                sadBloc.restaurantList[index];
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
                                      //   final removedName = restaurantName;
                                      //   restaurantsList.removeAt(restaurantName);
                                      //   ScaffoldMessenger.of(
                                      //     context,
                                      //   ).clearSnackBars();
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //     SnackBar(
                                      //       backgroundColor: Colors.grey.shade600,
                                      //       content: Text("$removedName removed"),
                                      //       duration: const Duration(seconds: 3),
                                      //       behavior: SnackBarBehavior.floating,
                                      //       action: SnackBarAction(
                                      //         label: "Undo",
                                      //         onPressed: () {
                                      //           restaurantsList.addRestaurant(
                                      //             removedName,
                                      //           );
                                      //         },
                                      //         textColor: Colors.orangeAccent,
                                      //       ),
                                      //     ),
                                      //   );
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
                                // showModalBottomSheet(
                                //   isScrollControlled: true,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.vertical(
                                //       top: Radius.circular(20),
                                //     ),
                                //   ),
                                //   context: context,
                                //   builder: (context) {
                                //     String selectedRestaurant =
                                //         restaurantsList.restaurants[Random()
                                //             .nextInt(
                                //               restaurantsList.restaurants.length,
                                //             )];
                                //     return StatefulBuilder(
                                //       builder: (context, setModalState) {
                                //         return Container(
                                //           height: 400,
                                //           width: double.infinity,
                                //           padding: const EdgeInsets.all(24),
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               Text(
                                //                 "🎉 Today's Pick!",
                                //                 style: TextStyle(
                                //                   fontSize: 36,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //               ),
                                //               SizedBox(height: 16),
                                //               isLoading
                                //                   ? Lottie.asset(
                                //                       "assets/loader.json",
                                //                       height: 100,
                                //                       width: 100,
                                //                       repeat: true,
                                //                       animate: true,
                                //                     )
                                //                   : Text(
                                //                       selectedRestaurant,
                                //                       style: TextStyle(
                                //                         fontSize: 28,
                                //                         color: Colors.deepOrange,
                                //                         fontWeight: FontWeight.w700,
                                //                       ),
                                //                       textAlign: TextAlign.center,
                                //                     ),
                                //               SizedBox(height: 40),
                                //               ElevatedButton.icon(
                                //                 onPressed: () {
                                //                   final newSelectedRestaurant =
                                //                       restaurantsList
                                //                           .restaurants[Random()
                                //                           .nextInt(
                                //                             restaurantsList
                                //                                 .restaurants
                                //                                 .length,
                                //                           )];

                                //                   setModalState(() {
                                //                     isLoading = true;
                                //                   });

                                //                   Future.delayed(
                                //                     Duration(seconds: 3),
                                //                     () {
                                //                       setModalState(() {
                                //                         selectedRestaurant =
                                //                             newSelectedRestaurant;
                                //                         isLoading = false;
                                //                       });
                                //                     },
                                //                   );
                                //                 },
                                //                 icon: Icon(Icons.refresh),
                                //                 label: Text(
                                //                   "Spin Again",
                                //                   style: TextStyle(fontSize: 18),
                                //                 ),
                                //                 style: ElevatedButton.styleFrom(
                                //                   backgroundColor:
                                //                       Colors.deepOrange,
                                //                   foregroundColor: Colors.white,
                                //                   shape: RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius.circular(12),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   },
                                // );
                              },
                              child: Image.asset(
                                "assets/dice.png",
                                height: 90,
                                width: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
