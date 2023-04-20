import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  BigInt? PRODUCT_ID;
  BigInt? BUCKET_ID;
  String? name;
  String? bar_cd;
  int? delete_flag;
  DateTime? create_date;
  DateTime? update_date;

  ProductService({
    required this.PRODUCT_ID,
    required this.BUCKET_ID,
    required this.name,
    required this.bar_cd,
    this.delete_flag,
    this.create_date,
    this.update_date,
  });

  factory ProductService.fromMap(Map<String, dynamic> json) =>
      new ProductService(
          PRODUCT_ID: json['PRODUCT_ID'],
          BUCKET_ID: json['BUCKET_ID'],
          name: json['name'],
          bar_cd: json['bar_cd'],
          delete_flag: json['delete_flag'],
          create_date: json['create_date'],
          update_date: json['update_date']);

  Map<String, dynamic> toMap() {
    return {
      'PRODUCT_ID': PRODUCT_ID,
      'BUCKET_ID': BUCKET_ID,
      'name': name,
      'bar_cd': bar_cd,
      'delete_flag': delete_flag,
      'create_date': create_date,
      'update_date': update_date
    };
  }
}

const PROTOCOL = 'http';
const DOMAIN = 'localhost:9000';

// Future<ProductService> productadd(String route, [dynamic data]) async {
//   var dataStr = jsonEncode(data);
//   var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
//   var result = await http.get(Uri.parse(url));

  
// }
