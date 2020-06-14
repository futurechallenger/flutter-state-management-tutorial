import 'package:scoped_model_tutorial/models/catalog_info.dart';
import 'base_model.dart';

class CatalogModel extends BaseModel {
  CatalogInfo _catalogInfo;

  CatalogInfo get catalog => _catalogInfo;
  set catalog(CatalogInfo catalogInfo) => _catalogInfo = catalogInfo;

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) =>
      Item(id, CatalogInfo.itemNames[id % CatalogInfo.itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}
