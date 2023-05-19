import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:frontend/page/response/mobileScreenLayout.dart';
import 'package:frontend/page/response/responsiveLayoutScreen.dart';
import 'package:frontend/page/response/webScreenLayout.dart';
import 'package:frontend/services/authService.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());

  Widget buildLoginButton() {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.network(
        //     'https://csemsyfvlkikwoggzrze.supabase.co/storage/v1/object/public/public/barcode.jpg'),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            controller.login();
          },
          child: SizedBox(width: 200, child: Text('google login')),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (controller.googleAccount.value == null)
        return buildLoginButton();
      else
        return ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout());
    }));
  }
}
