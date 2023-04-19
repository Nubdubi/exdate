import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class ProductAddPage extends StatefulWidget {
  ProductAddPage({Key? key}) : super(key: key);

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  String result = '';
  TextEditingController barcodeinput = TextEditingController();
  TextEditingController titleinput = TextEditingController();
  TextEditingController exdateinput = TextEditingController();
  TextEditingController placeinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map data;
    List productData = [];
    String productName = '';
    getBarcode(barcode) async {
      http.Response response = await http.get(Uri.parse(
          'https://openapi.foodsafetykorea.go.kr/api/e5999307e832428b9a4e/C005/json/1/10/BAR_CD=$barcode'));
      // debugPrint(response.body);
      data = json.decode(response.body);
      print(data);
      print(data['C005']['RESULT']['CODE']);
      if (data['C005']['RESULT']['CODE'] == 'INFO-000') {
        print(data['C005']['row'][0]['PRDLST_NM']);
        titleinput.text = data['C005']['row'][0]['PRDLST_NM'];
        exdateinput.text = data['C005']['row'][0]['POG_DAYCNT'];
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (productName.isNotEmpty) Text(productName),
            SizedBox(
                width: 800,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('바코드'),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: barcodeinput,
                        onSubmitted: (value) {
                          setState(() {
                            getBarcode(barcodeinput.text);
                          });
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SimpleBarcodeScannerPage(),
                            ));
                        setState(() {
                          if (res is String) {
                            getBarcode(res);
                            barcodeinput.text = res;
                          }
                        });
                      },
                      child: Icon(Icons.barcode_reader),
                    ),
                  ],
                )),
            InputSection(
              name: '상품명',
              controller: titleinput,
            ),
            InputSection(
              name: '유통기한',
              controller: exdateinput,
            ),
            InputSection(
              name: '위치',
              controller: placeinput,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InputSection extends StatelessWidget {
  InputSection({super.key, required this.name, required this.controller});
  String name;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
