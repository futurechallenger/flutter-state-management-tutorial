import 'dart:async';

import 'package:bloc_tutorial/blocs/base_bloc.dart';
import 'package:bloc_tutorial/models/catalog.dart';

class CatalogBloc extends BaseBloc {
  CatalogModel _catalog;

  // final _controller = StreamController<CatalogModel>.broadcast();
  final _controller = StreamController<CatalogModel>();

  Stream<CatalogModel> get stream => _controller.stream;

  set catalog(CatalogModel catalog) {
    _catalog = catalog;
    _controller.sink.add(catalog);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
