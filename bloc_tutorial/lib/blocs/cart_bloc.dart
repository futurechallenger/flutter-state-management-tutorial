import 'dart:async';

import 'package:bloc_tutorial/blocs/base_bloc.dart';
import 'package:bloc_tutorial/models/cart.dart';
import 'package:bloc_tutorial/models/catalog.dart';

class CartBloc extends BaseBloc {
  CartModel _cart = CartModel();
  CartModel get cart => _cart;
  set cart(CartModel c) => _cart = c;

  final _controller = StreamController<Item>.broadcast();

  List<int> _itemIds = [];

  Stream<Item> get stream => _controller.stream;

  /// List of items in the cart.
  List<Item> get items =>
      _itemIds.map((id) => cart.catalog.getById(id)).toList();

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
