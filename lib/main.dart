import 'package:fake_store/view_model/products_view_model.dart';
import 'package:fake_store/screens/home.dart';
import 'package:fake_store/view_model/shopping_card_view_model.dart';
import 'package:fake_store/view_model/single_products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'others/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProductsViewModel()),
      ChangeNotifierProvider(create: (context) => ProductViewModel()),
      ChangeNotifierProvider(create: (context) => ShoppingCardViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: Home(),
    );
  }
}
