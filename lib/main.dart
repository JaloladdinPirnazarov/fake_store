import 'package:fake_store/providers/provider.dart';
import 'package:fake_store/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'others/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Home(),
      ),
    );
  }
}
