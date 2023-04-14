import 'package:frontend/model/product.dart';
import 'package:hive/hive.dart';

class ProductBox {
  static Box<Products> getProducts() => Hive.box<Products>('products');
}
