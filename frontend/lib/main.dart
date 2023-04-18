import 'package:flutter/material.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/page/mainpage.dart';
import 'package:frontend/page/response/mobileScreenLayout.dart';
import 'package:frontend/page/response/webScreenLayout.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'page/response/responsiveLayoutScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductsAdapter());
  await Hive.openBox<Products>('products');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
