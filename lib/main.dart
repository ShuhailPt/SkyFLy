// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/main_provider.dart';
import 'View/bottom_navigation.dart';
import 'View/flight_select_screen.dart';
import 'View/home_screen.dart';
import 'View/login_screen.dart';
import 'View/seat_selecting_screen.dart';
import 'View/boarding_pass_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}





















































































































































































































