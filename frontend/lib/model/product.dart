import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String barcode;

  @HiveField(2)
  late DateTime datetime;

  @HiveField(3)
  late bool ex = false;
}
