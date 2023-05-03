import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// class ProductService {
//   BigInt? PRODUCT_ID;
//   BigInt? BUCKET_ID;
//   String? name;
//   String? bar_cd;
//   int? delete_flag;
//   DateTime? create_date;
//   DateTime? update_date;

//   ProductService({
//     required this.PRODUCT_ID,
//     required this.BUCKET_ID,
//     required this.name,
//     required this.bar_cd,
//     this.delete_flag,
//     this.create_date,
//     this.update_date,
//   });

//   factory ProductService.fromMap(Map<String, dynamic> json) =>
//       new ProductService(
//           PRODUCT_ID: json['PRODUCT_ID'],
//           BUCKET_ID: json['BUCKET_ID'],
//           name: json['name'],
//           bar_cd: json['bar_cd'],
//           delete_flag: json['delete_flag'],
//           create_date: json['create_date'],
//           update_date: json['update_date']);

//   Map<String, dynamic> toMap() {
//     return {
//       'PRODUCT_ID': PRODUCT_ID,
//       'BUCKET_ID': BUCKET_ID,
//       'name': name,
//       'bar_cd': bar_cd,
//       'delete_flag': delete_flag,
//       'create_date': create_date,
//       'update_date': update_date
//     };
//   }
// }

const PROTOCOL = 'http';
const DOMAIN = 'localhost:9000';

// Future<ProductService> productadd(String route, [dynamic data]) async {
//   var dataStr = jsonEncode(data);
//   var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
//   var result = await http.get(Uri.parse(url));

// }

class ProdcutController {
  var date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  addproduct(bucketid, name, count, exdate, barcode) async {
    var data = {
      "bucket_id": bucketid,
      "name": name,
      "date": date,
      "amount": count,
      "expiration_date": exdate,
      "bar_cd": barcode,
    };
    Map<String, String> requestHeaders = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (kDebugMode) {
      http.Response response = await http.post(
          Uri.parse('http://localhost:9000/product'),
          headers: requestHeaders,
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print(response);
      } else {
        print(response.body);
      }
    } else {
      http.Response response = await http.post(
          Uri.parse('http:// castpro.site:9000/product'),
          headers: requestHeaders,
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print(response);
      } else {
        print(response.body);
      }
    }
  }

  addBucket(
    userid,
    name,
  ) async {
    var data = {
      "user_id": userid,
      "name": name,
      "date": date,
    };
    Map<String, String> requestHeaders = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse('http://localhost:9000/bucket'),
        headers: requestHeaders,
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response);
    }
  }

  readdata(bucketId) async {
    var data = {
      "bucket_id": bucketId,
    };

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    http.Response response = await http.get(
      Uri.parse('http://localhost:9000/product?bucket_id=$bucketId'),
      headers: requestHeaders,
    );
    // debugPrint(response.body);
    // var data = json.decode(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      print('false');
    }
    //   print(data['C005']['RESULT']['CODE']);
    //   if (data['C005']['RESULT']['CODE'] == 'INFO-000') {
    //     print(data['C005']['row'][0]['PRDLST_NM']);
    //   }
  }
}
