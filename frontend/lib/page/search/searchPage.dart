import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              controller: textEditingController,
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('hey'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
