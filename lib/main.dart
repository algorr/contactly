import 'package:contactly/features/view/home/home_view.dart';
import 'package:flutter/material.dart';

import 'features/resources/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getAppTheme(),
      home: const HomeView(),
    );
  }
}
