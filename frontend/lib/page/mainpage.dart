import 'package:flutter/material.dart';
import 'package:frontend/boxes/box.dart';
import 'package:frontend/model/product.dart';
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
    return Scaffold(
        body: FutureBuilder(
      future: fetch(),
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data.toString());
        if (!snapshot.hasData) return CircularProgressIndicator();
        return SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                print(snapshot.data.toString());
                return ListTile(
                  title: Text(snapshot.data[0].toString()),
                );
              },
            )
          ]),
        );
      },
    ));
  }
}
