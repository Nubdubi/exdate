import 'package:flutter/material.dart';

class BucketPage extends StatefulWidget {
  BucketPage({Key? key}) : super(key: key);

  @override
  State<BucketPage> createState() => _BucketPageState();
}

class _BucketPageState extends State<BucketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  title: Text(
                    'bucket name',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '3개',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
