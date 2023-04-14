import 'package:flutter/material.dart';
import 'package:frontend/boxes/box.dart';
import 'package:frontend/model/product.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ExSearchPage extends StatefulWidget {
  ExSearchPage({Key? key}) : super(key: key);

  @override
  State<ExSearchPage> createState() => _ExSearchPageState();
}

class _ExSearchPageState extends State<ExSearchPage> {
  @override
  Widget build(BuildContext context) {
    String result = '';
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(result),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(),
              ),
              ElevatedButton(onPressed: () {}, child: Text('search'))
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SimpleBarcodeScannerPage(),
              ));
          setState(() {
            if (res is String) {
              result = res;
            }
          });
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
