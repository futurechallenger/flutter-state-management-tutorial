// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:bloc_tutorial/blocs/bloc_provider.dart';
import 'package:bloc_tutorial/blocs/cart_bloc.dart';
import 'package:bloc_tutorial/blocs/catalog_bloc.dart';
import 'package:bloc_tutorial/models/cart.dart';
import 'package:bloc_tutorial/models/catalog.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {
                  final catalogBloc = BlocProvider.of<CatalogBloc>(context);
                  final catalog = CatalogModel();
                  catalogBloc.catalog = catalog;
                  final cartBloc = BlocProvider.of<CartBloc>(context);
                  final cart = CartModel();
                  cart.catalog = catalog;
                  cartBloc.cart = cart;
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
