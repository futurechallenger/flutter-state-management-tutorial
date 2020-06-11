// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:bloc_tutorial/blocs/bloc_provider.dart';
import 'package:bloc_tutorial/blocs/cart_bloc.dart';
import 'package:bloc_tutorial/blocs/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_tutorial/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((context, index) => StreamBuilder(
                    stream: BlocProvider.of<CatalogBloc>(context).stream,
                    builder: (context, snapshot) {
                      final catalog = snapshot.data;
                      if (catalog == null) {
                        // TODO: A better way to remind users.
                        return Center(
                          child: Text('Loading...'),
                        );
                      }

                      return _MyListItem(
                        index,
                        catalog: catalog,
                      );
                    })),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  final CatalogModel catalog;

  const _AddButton({Key key, @required this.item, @required this.catalog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return StreamBuilder<Item>(
        stream: cartBloc.stream,
        builder: (context, snapshot) {
          return FlatButton(
            // onPressed: cart.items.contains(item) ? null : () => cart.add(item),
            onPressed: cartBloc.items.contains(item)
                ? null
                : () => cartBloc.addItem(item),
            splashColor: Theme.of(context).primaryColor,
            child: cartBloc.items.contains(item)
                ? Icon(Icons.check, semanticLabel: 'ADDED')
                : Text('ADD'),
          );
        });
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  final CatalogModel catalog;

  _MyListItem(this.index, {Key key, this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(
              item: item,
              catalog: catalog,
            ),
          ],
        ),
      ),
    );
  }
}
