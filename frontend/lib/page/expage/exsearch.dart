import 'package:flutter/material.dart';

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
                ElevatedButton(onPressed: () {}, child: const Text('search'))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: const Text('image'),
                  title: const Text('농심 신라면'),
                  subtitle: const Column(
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
    );
  }
}
