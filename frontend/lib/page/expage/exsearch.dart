import 'package:flutter/material.dart';
import 'package:frontend/boxes/box.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/page/products/productAddPage.dart';
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(initialValue: result),
                ),
                ElevatedButton(onPressed: () {}, child: Text('search'))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Text('image'),
                  title: Text('농심 신라면'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('유통기한 : 2022-02-03'),
                      Text('바코드 : 8080800'),
                      Text('등록일 : 2022-01-02')
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductAddPage(),
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
