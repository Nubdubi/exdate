import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/page/expage/exdata.dart';
import 'package:frontend/page/expage/exsearch.dart';
import 'package:get/get.dart';

class ExDate extends StatefulWidget {
  ExDate({Key? key}) : super(key: key);

  @override
  State<ExDate> createState() => _ExDateState();
}

class _ExDateState extends State<ExDate> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    String result = '';
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        endDrawer: Drawer(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Hello Barcode',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '● 버킷',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '● 캘린더',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      '● 환경설정',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
        appBar: AppBar(
          title: const Text(
            'Title',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(14, 12, 18, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: Color.fromRGBO(43, 41, 48, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        initialValue: result,
                        decoration: InputDecoration(
                            hintText: 'hint text',
                            fillColor: Color.fromRGBO(43, 41, 48, 1)),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ExSearchPage();
                              },
                              transitionDuration: const Duration(seconds: 1)));
                        },
                        child: AnimatedIcon(
                          icon: AnimatedIcons.search_ellipsis,
                          color: Colors.white,
                          progress: _controller,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  const Text('최근 등록 상품'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(189, 189, 189, 1),
                                    border: Border.all(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text('product name'),
                                const Text(
                                  '유통기한(2023-02-02)',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ),
              const TabBar(
                  padding: EdgeInsets.all(2),
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      text: '전체상품',
                    ),
                    Tab(
                      text: '기한임박',
                    ),
                    Tab(
                      text: '기한초과',
                    ),
                    Tab(
                      text: '소비완료',
                    ),
                  ]),
              Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: TabBarView(children: [
                    ListView.builder(
                      key: const PageStorageKey("LIST_VIEW"),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          leading: const Text(
                            'image',
                            style: TextStyle(color: Colors.white),
                          ),
                          title: const Text(
                            '농심 신라면',
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
                                    '바코드 : 8080800',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        '2022-01-02 ~',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '2022-02-03',
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
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 24,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color.fromRGBO(
                                          242, 184, 181, 1),
                                    ),
                                    child: const Center(
                                        child: Text('상태',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    96, 20, 16, 1),
                                                fontSize: 10))),
                                  ),
                                )
                              ]),
                        );
                      },
                    ),
                    const Text('a'),
                    const Text('b'),
                    const Text('c')
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
