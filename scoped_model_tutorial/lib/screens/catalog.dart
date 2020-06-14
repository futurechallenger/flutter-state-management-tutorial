// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_tutorial/models/catalog_info.dart';
import 'package:scoped_model_tutorial/scoped_models/cart_model.dart';
import 'package:scoped_model_tutorial/scoped_models/catalog_model.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        ScopedModelDescendant<CatalogModel>(builder: (context, child, model) {
      CatalogModel catalog = model;
      if (catalog == null)
        return Center(
          child: Text('Loading'),
        );

      return CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((context, index) => _MyListItem(
                      index,
                      catalog: catalog,
                    )),
          )
        ],
      );
    }));
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  // final CatalogModel catalog;

  const _AddButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartModel = ScopedModel.of<CartModel>(context, rebuildOnChange: true);

    return FlatButton(
      onPressed:
          cartModel.items.contains(item) ? null : () => cartModel.addItem(item),
      splashColor: Theme.of(context).primaryColor,
      child: cartModel.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
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

  _MyListItem(this.index, {Key key, @required this.catalog}) : super(key: key);

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
            ),
          ],
        ),
      ),
    );
  }
}
