import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transit_app/constants.dart';
import 'package:transit_app/screens/authScreens/landingScreen.dart';
import 'package:transit_app/screens/authScreens/loginScreen.dart';
import 'package:transit_app/screens/authScreens/signUpScreen.dart';
import 'package:transit_app/screens/home.dart';
import 'package:transit_app/screens/main_navigation.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
       // primaryColor: kPrimaryColor,
      ),
      home: const LandingScreen(),
    );
  }
}

