import 'package:flutter/material.dart';
import 'package:frontend/services/authService.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '317921682520-osl28bu3k92j0st1hjm9ehvc8m9n29jl.apps.googleusercontent.com',
  scopes: scopes,
);

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                authService.signIn();
              },
              child: Text('googlelogin'))),
    );
  }
}
