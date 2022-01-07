import 'package:fabrishop/data/models/product.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final List<Product> products;

  Category({this.id, this.name, this.description, this.products});
}
