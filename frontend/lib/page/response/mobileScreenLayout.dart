// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/page/response/navigationitems.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            color: const Color.fromARGB(255, 33, 31, 38),
            child: InkWell(
              onTap: () => print('tap on close'),
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
              // CupertinoTabBar(
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              //   currentIndex: _page,
              //   items: [
              //     BottomNavigationBarItem(
              //       label: 'home',
              //       icon: Icon(Icons.menu,
              //           color: _page == 0 ? Colors.pinkAccent : Colors.grey),
              //     ),
              //     // BottomNavigationBarItem(
              //     //     label: 'search',
              //     //     icon: Icon(Icons.search,
              //     //         color: _page == 1 ? Colors.pinkAccent : Colors.grey)),
              //     BottomNavigationBarItem(
              //         label: 'add',
              //         icon: Icon(Icons.add_box_outlined,
              //             color: _page == 1 ? Colors.pinkAccent : Colors.grey)),
              //     BottomNavigationBarItem(
              //         label: 'bucket',
              //         icon: Icon(CupertinoIcons.arrow_up_bin,
              //             color: _page == 2 ? Colors.pinkAccent : Colors.grey)),
              //     BottomNavigationBarItem(
              //         label: 'profile',
              //         icon: Icon(Icons.manage_accounts,
              //             color: _page == 3 ? Colors.pinkAccent : Colors.grey)),
              //   ],
              //   onTap: navigationTapped,
              // ),
            )));
  }
}
