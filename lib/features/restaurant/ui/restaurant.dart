import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/component/restaurant_button.dart';
import 'package:flutter_spin_and_dine/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:lottie/lottie.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantBloc restaurantBloc = RestaurantBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    restaurantBloc.add(RestaurantInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Restaurant Picker"))),
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        listenWhen: (previous, current) => current is RestaurantActionState,
        buildWhen: (previous, current) => current is! RestaurantActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case RestaurantLoadedState:
              final successState = state as RestaurantLoadedState;
              return successState.restaurants.isEmpty
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
                            itemCount: successState.restaurants.length,
                            itemBuilder: (context, int index) {
                              final String restaurantName =
                                  successState.restaurants[index];

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
                                        restaurantBloc.add(
                                          RestaurantRemoveButtonClicked(
                                            restaurantName: removedName,
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
                      ],
                    );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

// Column(
//                           children: [
//                             RestaurantButton(icon: null),

//                             const SizedBox(height: 20),

//                             Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(90),
//                                 onTap: () {
//                                   showModalBottomSheet(
//                                     isScrollControlled: true,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(20),
//                                       ),
//                                     ),
//                                     context: context,
//                                     builder: (context) {
//                                       String selectedRestaurant =
//                                           restaurantsList
//                                               .restaurants[Random().nextInt(
//                                             restaurantsList.restaurants.length,
//                                           )];

//                                       return StatefulBuilder(
//                                         builder: (context, setModalState) {
//                                           return Container(
//                                             height: 400,
//                                             width: double.infinity,
//                                             padding: const EdgeInsets.all(24),

//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "🎉 Today's Pick!",
//                                                   style: TextStyle(
//                                                     fontSize: 36,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),

//                                                 SizedBox(height: 16),

//                                                 isLoading
//                                                     ? Transform.scale(
//                                                         scale: 1.5,
//                                                         child: Lottie.asset(
//                                                           "assets/loader.json",
//                                                           height: 80,
//                                                           width: 80,
//                                                           fit: BoxFit.fill,
//                                                           repeat: true,
//                                                           animate: true,
//                                                         ),
//                                                       )
//                                                     : Text(
//                                                         selectedRestaurant,
//                                                         style: TextStyle(
//                                                           fontSize: 28,
//                                                           color:
//                                                               Colors.deepOrange,
//                                                           fontWeight:
//                                                               FontWeight.w700,
//                                                         ),
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ),

//                                                 SizedBox(height: 40),

//                                                 ElevatedButton.icon(
//                                                   onPressed: () {
//                                                     final newSelectedRestaurant =
//                                                         restaurantsList
//                                                             .restaurants[Random()
//                                                             .nextInt(
//                                                               restaurantsList
//                                                                   .restaurants
//                                                                   .length,
//                                                             )];

//                                                     setModalState(() {
//                                                       isLoading = true;
//                                                     });

//                                                     Future.delayed(
//                                                       Duration(seconds: 3),
//                                                       () {
//                                                         setModalState(() {
//                                                           selectedRestaurant =
//                                                               newSelectedRestaurant;
//                                                           isLoading = false;
//                                                         });
//                                                       },
//                                                     );
//                                                   },
//                                                   icon: Icon(Icons.refresh),
//                                                   label: Text(
//                                                     "Spin Again",
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                     ),
//                                                   ),
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         Colors.deepOrange,
//                                                     foregroundColor:
//                                                         Colors.white,
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                             12,
//                                                           ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: Image.asset(
//                                   "assets/dice.png",
//                                   height: 90,
//                                   width: 90,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
