import 'package:flutter/material.dart';
import 'package:effective_dart_style_in_flutter/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Effective Dart Style, Usage, and Design',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const HomePage(title: 'Effective Dart Style'),
      );
}
