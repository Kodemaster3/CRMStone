// import 'dart:developer';

// import 'package:flutter/material.dart';
// //import 'package:shared_preferences/shared_preferences.dart';

// import 'pages/main_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // log(context.widget.key.toString());
//     //  SharedPreferences sharedPreferences;
//     return MaterialApp(
//       title: 'Calc Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MainPage(),
//     );
//   }
// }

// // import 'dart:convert';
// // import 'dart:developer';

// // void main() {
// //   var user = User(
// //       name: 'Sergey',
// //       age: 33,
// //       location: Location(city: 'Kharkiv', zipCode: 61001));

// //   log(user.toJson());
// // }



// // class User {
// //   String name;
// //   int age;
// //   Location location;

// //   User({
// //     required this.name,
// //     required this.age,
// //     required this.location,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'name': name,
// //       'age': age,
// //       'location': location.toMap(),
// //     };
// //   }

// //   factory User.fromMap(Map<String, dynamic> map) {
// //     return User(
// //       name: map['name'],
// //       age: map['age'],
// //       location: Location.fromMap(map['location']),
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory User.fromJson(String source) => User.fromMap(json.decode(source));
// // }

// // class Location {
// //   String city;
// //   int zipCode;

// //   Location({
// //     required this.city,
// //     required this.zipCode,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'city': city,
// //       'zipCode': zipCode,
// //     };
// //   }

// //   factory Location.fromMap(Map<String, dynamic> map) {
// //     return Location(
// //       city: map['city'],
// //       zipCode: map['zipCode'],
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory Location.fromJson(String source) =>
// //       Location.fromMap(json.decode(source));
// // }
