import 'dart:async';

import 'package:bloc_tutorial/blocs/base_bloc.dart';
import 'package:bloc_tutorial/models/cart.dart';
import 'package:bloc_tutorial/models/catalog.dart';

class CartBloc extends BaseBloc {
  CartBloc({this.catalog});

  CartModel _cart;
  CartModel get cart => _cart;
  set cart(CartModel c) {
    if (_cart == null) _cart = c;
  }

  final _controller = StreamController<Item>();

  CatalogModel catalog;
  // CatalogModel get catalog => _catalog;
  // set catalog(CatalogModel catalog) => _catalog = catalog;

  List<int> _itemIds = [];

  Stream<Item> get stream => _controller.stream;

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void addItem(Item item) {
    _itemIds.add(item.id);
    _cart.add(item);
    _controller.sink.add(item);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
