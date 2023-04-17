import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 800,
                child: Row(
                  children: [
                    Text('바코드'),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: barcodeinput,
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
