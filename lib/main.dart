
import 'package:flutter/material.dart';
import 'package:zpassesment/resource/app_strings.dart';
import 'package:zpassesment/ui/country_landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:const  CountryLandingScreen(title: 'Country'),
    );
  }
}
