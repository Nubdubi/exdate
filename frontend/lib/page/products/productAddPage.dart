import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/productService.dart';
import 'package:get/get.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

final _formkey = GlobalKey<FormState>();

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
  TextEditingController countinput = TextEditingController();

  TextEditingController placeinput = TextEditingController();
  ProdcutController prodcutController = ProdcutController();

  @override
  Widget build(BuildContext context) {
    Map data;
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

    readdata(barcode) async {
      http.Response response =
          await http.get(Uri.parse('https://localhost:9000/'));
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

    addBarcode(bucketid, userid, name) async {
      data = {"user_id": 2, "name": "2222", "date": "2023-04-21 00:00:00"};
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

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Barcode capture'),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: barcodeinput,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () async {
                          // var res = await Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const SimpleBarcodeScannerPage(),
                          //     ));
                          // setState(() {
                          //   if (res is String) {
                          //     getBarcode(res);
                          //     barcodeinput.text = res;

                          //     getBarcode(barcodeinput.text);
                          //   }
                          // });
                        },
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Barcode',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.white)),
                  onFieldSubmitted: (value) {
                    getBarcode(value);
                  },
                ),
              ),
              ProductInput(
                text: 'Product Name',
                validator: 'Enter Product Name',
                controller: titleinput,
                keytype: TextInputType.text,
              ),
              ProductInput(
                text: 'Exdate',
                validator: 'Enter Exdate',
                controller: exdateinput,
                keytype: TextInputType.phone,
              ),
              ProductInput(
                text: 'count',
                validator: 'Enter count',
                controller: countinput,
                keytype: TextInputType.number,
              ),

              if (productName.isNotEmpty) Text(productName),
              // SizedBox(
              //     width: 800,
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text('바코드'),
              //         SizedBox(
              //           width: 300,
              //           child: TextField(
              //             controller: barcodeinput,
              //             onSubmitted: (value) {
              //               setState(() {
              //                 getBarcode(barcodeinput.text);
              //               });
              //             },
              //           ),
              //         ),
              //       ],
              //     )),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState == null) {
                      prodcutController.addproduct(1, titleinput.text,
                          countinput.text, exdateinput.text, barcodeinput.text);
                      barcodeinput.clear();
                      titleinput.clear();
                      exdateinput.clear();
                      titleinput.clear();
                      countinput.clear();
                      Get.snackbar(
                        'productadd success',
                        '등록완료',
                        backgroundColor: Colors.white,
                      );
                    }
                    if (_formkey.currentState!.validate()) {
                      print('에러가 없습니다.');
                    } else {
                      print('에러!!!!!!');
                    }
                  },
                  child: Text('상품등록')),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductInput extends StatefulWidget {
  ProductInput(
      {super.key,
      required this.text,
      required this.validator,
      required this.controller,
      required this.keytype});
  String text;
  String validator;
  TextEditingController controller;
  TextInputType keytype;

  @override
  State<ProductInput> createState() => _ProductInputState();
}

class _ProductInputState extends State<ProductInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: widget.keytype,
        controller: widget.controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: widget.text,
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.white)),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.validator;
          }
          return null;
        },
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(name),
        SizedBox(
          width: 30,
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
