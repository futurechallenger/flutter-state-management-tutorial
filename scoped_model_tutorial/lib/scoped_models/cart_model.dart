import 'package:scoped_model_tutorial/models/cart_info.dart';
import 'package:scoped_model_tutorial/models/catalog_info.dart';
import 'base_model.dart';
import 'catalog_model.dart';

class CartModel extends BaseModel {
  CartInfo _cartInfo;
  CatalogModel _catalog;

  CartModel();

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    if (_cartInfo != null) _cartInfo = null;
    _cartInfo = CartInfo(catalog: _catalog.catalog, itemIds: []);

    notifyListeners();
  }

  void addItem(Item item) {
    assert(_cartInfo != null);

    _cartInfo.itemIds.add(item.id);
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items =>
      _cartInfo.itemIds.map((id) => _catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);
}
