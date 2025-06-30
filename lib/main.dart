import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spin_and_dine/bloc/sad_bloc.dart';
import 'package:flutter_spin_and_dine/screens/splas_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SadBloc>(
      create: (context) => SadBloc(),
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
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
