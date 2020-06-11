import 'package:bloc_tutorial/blocs/cart_bloc.dart';
import 'package:bloc_tutorial/blocs/catalog_bloc.dart';
import 'package:bloc_tutorial/screens/cart.dart';
import 'package:bloc_tutorial/screens/catalog.dart';
import 'package:bloc_tutorial/screens/login.dart';
import 'package:flutter/material.dart';
import 'blocs/bloc_provider.dart';
import 'common/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // In this app, catalog will never change.
    // But if catalog changes, the new catalog would pass through `snapshot`.
    return BlocProvider<CatalogBloc>(
      bloc: CatalogBloc(),
      child: BlocProvider<CartBloc>(
        bloc: CartBloc(),
        child: MaterialApp(
          title: 'Provider Demo',
          theme: appTheme,
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
