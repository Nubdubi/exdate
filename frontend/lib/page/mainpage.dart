import 'package:flutter/material.dart';
import 'package:frontend/boxes/box.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/page/expage/exdata.dart';
import 'package:frontend/page/expage/exsearch.dart';
import 'package:frontend/page/products/productAddPage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box('products').close();
    super.dispose();
  }

  Future fetch() async {
    var res = await http.get(Uri.parse('http://localhost:9000'),
        headers: {"user-header": "1234"});

    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: fetch(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data.toString());
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    print(snapshot.data.toString());
                    return ListTile(
                      leading: Text('상품이미지'),
                      title: Text('상품명'),
                      subtitle: Text('유효일자 - 2030-03-02'),
                    );
                  },
                )
              ]),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ProductAddPage(),
                ),
              );
            },
            child: Icon(Icons.search)),
      ),
    );
  }
}
