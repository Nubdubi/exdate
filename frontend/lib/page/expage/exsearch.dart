import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/page/expage/exdata.dart';
import 'package:get/get.dart';

class ExSearchPage extends StatefulWidget {
  ExSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExSearchPage> createState() => _ExSearchPageState();
}

class _ExSearchPageState extends State<ExSearchPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    String result = '';
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(43, 41, 48, 1),
        ),
        body: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(initialValue: result),
                ),
              ],
            ),
          ),
        ]));
  }
}
