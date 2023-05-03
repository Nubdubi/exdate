import 'package:flutter/material.dart';
import 'package:frontend/page/response/mobileScreenLayout.dart';
import 'package:frontend/page/response/navigationitems.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    int _page = 0;

    // @override
    // void initState() {
    //   super.initState();
    //   pageController = PageController();
    // }

    @override
    void dispose() {
      super.dispose();
      pageController.dispose();
    }

    void navigationTapped(int page) {
      pageController.jumpToPage(page);
    }

    void onPageChanged(int page) {
      setState(() {
        _page = page;
      });
    }

    return Center(
      child: Container(width: 300, child: MobileScreenLayout()),
    );

    // return Scaffold(
    //     body: Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Expanded(
    //       flex: 1,
    //       child: Container(
    //         color: Colors.white,
    //         width: MediaQuery.of(context).size.width * 0.1,
    //         child: Column(
    //           children: [
    //             ListTile(
    //               onTap: () {
    //                 navigationTapped(0);
    //                 onPageChanged(0);
    //                 print(_page);
    //               },
    //               title: Text('home'),
    //               selectedColor: Colors.amber,
    //               selectedTileColor: Colors.amber,
    //               tileColor: _page == 0 ? Colors.pinkAccent : Colors.grey,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 navigationTapped(1);
    //                 onPageChanged(1);
    //                 print(_page);
    //               },
    //               title: Text('search'),
    //               tileColor: _page == 1 ? Colors.pinkAccent : Colors.grey,
    //             ),
    //             ListTile(
    //               onTap: () {
    //                 navigationTapped(2);
    //                 onPageChanged(2);
    //               },
    //               title: Text('add'),
    //               tileColor: _page == 2 ? Colors.pinkAccent : Colors.grey,
    //             ),
    //             // ListTile(
    //             //   onTap: () {
    //             //     navigationTapped(3);
    //             //     onPageChanged(3);
    //             //   },
    //             //   title: Text('calendar'),
    //             //   tileColor: _page == 4 ? Colors.pinkAccent : Colors.grey,
    //             // ),
    //             ListTile(
    //               onTap: () {
    //                 navigationTapped(3);
    //                 onPageChanged(3);
    //               },
    //               title: Text('profile'),
    //               tileColor: _page == 3 ? Colors.pinkAccent : Colors.grey,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       flex: 9,
    //       child: Container(
    //         width: MediaQuery.of(context).size.width * 0.8,
    //         height: MediaQuery.of(context).size.height,
    //         child: PageView(
    //           physics: const NeverScrollableScrollPhysics(),
    //           controller: pageController,
    //           onPageChanged: onPageChanged,
    //           children: homeScreenItems,
    //         ),
    //       ),
    //     ),
    //   ],
    // ));
  }
}
