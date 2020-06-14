import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_tutorial/scoped_models/cart_model.dart';
import 'package:scoped_model_tutorial/scoped_models/catalog_model.dart';
import 'package:scoped_model_tutorial/screens/cart.dart';
import 'package:scoped_model_tutorial/screens/catalog.dart';
import 'package:scoped_model_tutorial/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CatalogModel>(
      model: CatalogModel(),
      child: ScopedModel(
        model: CartModel(),
        child: MaterialApp(
          title: 'ScopedModel Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => MyLogin(),
            '/catalog': (context) => MyCatalog(),
            '/cart': (context) => MyCart(),
          },
        ),
      ),
    );
  }
}
