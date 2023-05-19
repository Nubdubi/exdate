import 'package:flutter/material.dart';
import 'package:frontend/services/productService.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TabProdcutList extends StatefulWidget {
  TabProdcutList(
      {Key? key,
      required this.checked,
      required this.name,
      required this.img,
      required this.barcode,
      required this.date,
      required this.exdate,
      required this.itemlenght})
      : super(key: key);
  bool checked;
  String name;
  String img;
  String barcode;
  DateTime date;
  DateTime exdate;
  int itemlenght;

  @override
  State<TabProdcutList> createState() => _TabProdcutListState();
}

class _TabProdcutListState extends State<TabProdcutList> {
  ProductController productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productController.readdata('1'),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            key: const PageStorageKey("LIST_VIEW"),
            itemCount: snapshot.data.lenght ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    widget.img[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    snapshot.data[index]['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.barcode,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                          ),
                          Row(
                            children: [
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(widget.date)
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              const Text('~'),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(widget.exdate)
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            'n EA',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'MM.dd',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                  trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: widget.checked,
                          onChanged: (value) {
                            setState(() {
                              widget.checked = value!;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 24,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(242, 184, 181, 1),
                            ),
                            child: const Center(
                                child: Text('상태',
                                    style: TextStyle(
                                        color: Color.fromRGBO(96, 20, 16, 1),
                                        fontSize: 10))),
                          ),
                        )
                      ]),
                ),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
