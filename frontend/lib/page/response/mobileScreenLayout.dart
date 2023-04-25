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
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home,
                color: _page == 0 ? Colors.pinkAccent : Colors.grey),
          ),
          BottomNavigationBarItem(
              label: 'search',
              icon: Icon(Icons.search,
                  color: _page == 1 ? Colors.pinkAccent : Colors.grey)),
          BottomNavigationBarItem(
              label: 'add',
              icon: Icon(Icons.add_box_rounded,
                  color: _page == 2 ? Colors.pinkAccent : Colors.grey)),
          BottomNavigationBarItem(
              label: 'calendar',
              icon: Icon(Icons.calendar_month,
                  color: _page == 3 ? Colors.pinkAccent : Colors.grey)),
          BottomNavigationBarItem(
              label: 'profile',
              icon: Icon(Icons.settings,
                  color: _page == 4 ? Colors.pinkAccent : Colors.grey)),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
