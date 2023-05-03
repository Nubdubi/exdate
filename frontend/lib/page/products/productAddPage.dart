import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/page/expage/exdata.dart';
import 'package:frontend/page/mainpage.dart';
import 'package:frontend/services/productService.dart';
import 'package:get/get.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:date_count_down/date_count_down.dart';

final _formkey = GlobalKey<FormState>();
List<String> dropdownList = ['1', '2', '3'];

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
  TextEditingController companyinput = TextEditingController();

  TextEditingController placeinput = TextEditingController();
  TextEditingController memoinput = TextEditingController();

  ProdcutController prodcutController = ProdcutController();

  TextEditingController leftimecontroller = TextEditingController();
  String selectedDropdown = dropdownList.first;
  bool isSwitched = false;

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
      if (kDebugMode) {
        http.Response response = await http.post(
            Uri.parse('http://localhost:9000/bucket'),
            headers: requestHeaders,
            body: jsonEncode(data));
        if (response.statusCode == 200) {
          print(response);
        }
      } else {
        http.Response response = await http.post(
            Uri.parse('http://castpro.site:9000/bucket'),
            headers: requestHeaders,
            body: jsonEncode(data));
        if (response.statusCode == 200) {
          print(response);
        }
      }
    }

    var _toDay = DateTime.now();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text('이미지'),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 52, 59, 1),
                              border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(54, 52, 59, 1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.5),
                                  spreadRadius: 0.3,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                                color: Color.fromRGBO(208, 188, 255, 1),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),

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
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Color.fromRGBO(208, 188, 255, 1),
                          ),
                        ),
                        labelText: '바코드',
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.white)),
                    onFieldSubmitted: (value) {
                      getBarcode(value);
                    },
                  ),
                ),
                ProductInput(
                  text: '상품명',
                  validator: 'Enter Product Name',
                  controller: titleinput,
                  keytype: TextInputType.text,
                ),
                ProductInput(
                  text: '제조사',
                  validator: 'Enter Product Name',
                  controller: companyinput,
                  keytype: TextInputType.text,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: exdateinput,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: '유통기한',
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 68, 68, 68))),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '유통기한을 입력해주세요';
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      if (exdateinput.text.isNotEmpty) {
                        leftimecontroller
                            .text = int.parse(DateTime.parse(exdateinput.text)
                                .difference(DateTime.parse(_toDay.toString()))
                                .inDays
                                .toString())
                            .toString();
                        setState(() {});
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue:
                        DateFormat('yyyy-MM-dd').format(_toDay).toString(),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 68, 68, 68))),
                        label: Text('등록일'),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter count';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    enabled: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 68, 68, 68))),
                        label: Text('${leftimecontroller.text.toString()}일'),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: '버킷',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                    child: ButtonTheme(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        style: const TextStyle(color: Colors.white),
                        hint: const Text("버킷"),
                        isExpanded: true,
                        value: selectedDropdown,
                        elevation: 16,
                        underline: DropdownButtonHideUnderline(
                          child: Container(),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDropdown = newValue!;
                          });
                        },
                        items: dropdownList.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text(' $item'),
                            value: selectedDropdown = item,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                ProductInput(
                  text: '수량',
                  validator: 'Enter count',
                  controller: countinput,
                  keytype: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: 'Placeholder',
                          enabled: false,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 68, 68, 68))),
                              labelText: '상품상태',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter count';
                            }
                            return null;
                          },
                        ),
                      ),
                      Column(
                        children: [
                          const Text('소비여부'),
                          Switch(
                            key: Key("UNIQUE_KEY"),
                            value: isSwitched,
                            onChanged: (_) {
                              isSwitched = !isSwitched;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 100,
                    keyboardType: TextInputType.number,
                    controller: memoinput,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        label: Text('메모'),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter count';
                      }
                      return null;
                    },
                  ),
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            print('등록완료');
                            prodcutController.addproduct(
                                1,
                                titleinput.text,
                                countinput.text,
                                exdateinput.text,
                                barcodeinput.text);
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
                            Get.defaultDialog(
                                title: '등록완료 되었습니다.',
                                content: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('추가등록')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.replace(ExDate());
                                        },
                                        child: Text('메인화면')),
                                  ],
                                ));
                          } else {
                            print('에러!!!!!!');
                          }
                        },
                        child: const Text('상품등록')),
                  ],
                ),
              ],
            ),
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
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.white)),
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
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
