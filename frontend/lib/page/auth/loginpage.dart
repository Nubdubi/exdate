import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/page/response/mobileScreenLayout.dart';
import 'package:frontend/page/response/responsiveLayoutScreen.dart';
import 'package:frontend/page/response/webScreenLayout.dart';
import 'package:frontend/services/authService.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart ' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());

  Widget buildLoginButton() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            controller.login();
          },
          child: Text('login')),
    );
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
