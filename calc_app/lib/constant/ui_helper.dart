import 'package:flutter/material.dart';

const double elevationView = 5;

final themeData = ThemeData(
  primaryColor: Colors.green,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[400],
    iconTheme: const IconThemeData(color: Colors.brown),
    titleTextStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 20,
    ),
  ),
  textTheme: const TextTheme(
    button: TextStyle(fontSize: 22.0),
  ),
);
