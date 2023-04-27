import 'package:flutter/material.dart';
import 'package:frontend/page/calendar/calendarPage.dart';
import 'package:frontend/page/expage/exdata.dart';
import 'package:frontend/page/expage/exsearch.dart';
import 'package:frontend/page/products/productAddPage.dart';
import 'package:frontend/page/profile/profilePage.dart';
import 'package:frontend/page/search/searchPage.dart';

List<Widget> homeScreenItems = [
  // BlockTest(),
  ExDate(),
  ProductAddPage(),
  CalendarPage(),
  ProfilePage(),
];
